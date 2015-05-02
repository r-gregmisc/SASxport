# $Id$

make.density <- function(m, data, monitor)
{
  if(!is.call(m)) stop("The model 'm' is not a model object (see ?model)")
  
  newcode <- function(...)
    {
      LIBS
      parms <- list(...)
      if(length(parms)==1 && is.list(parms[[1]])) 
        parms <- parms[[1]] 
      attach(parms)
      ASSIGNMENTS
      loglik <- 0.0 
      DENSITIES
      MONITOR
      detach(parms)       
      loglik
    }

  if(missing(data))
    {
      data <- m$data
    }
  m$data <- NULL

  for( expr in as.list(m))
    {
      if(expr=="model") next
      if(length(expr)==3)
        {
          CALL <- expr[[1]]
          LHS <- expr[[2]]
          RHS <- expr[[3]]
          if(CALL=="~")
            {
              newCALL <- insert.arg(RHS, LHS)

              ## convert from name to distribution function
              CALL = as.character(newCALL[[1]])
              fun <- lookup.table[[CALL]]$logdensity
              if(is.null(fun))
                {
                  fun <- lookup.table[[CALL]]$density
                  if(is.null(fun))
                    stop("Unable to find a density function for '", CALL,
                         "' in lookup.table")
                  else
                    {
                      newCALL[[1]] <- as.symbol(fun) 
                      newCALL <- bquote( log(.(newCALL)) )
                    }
                }
              else
                {
                  newCALL[[1]] <- as.symbol(fun)
                }

              
              ## put into function
              newcode <- insert.function( newcode, "DENSITIES",
                                         bquote(
                                         loglik <- loglik + sum(.(newCALL))
                                                )
                                         )

              ## Load appropriate package
              libname <- lookup.table[[CALL]]$package
              
              newcode <- insert.function( newcode, "LIBS",
                                         bquote(
                                                library( .(libname) )
                                                )
                                         )
              
            }
          else if (CALL=="<-")
            {
              newcode <- insert.function(newcode, "ASSIGNMENTS", expr)
            }
        }
      else if (!is.null(expr) && nchar(as.character(expr)) > 0 )
        {
          cat("Skipping expression with length!=3: '",
              deparse(substitute(expr)), "'\n", sep='')
        }
      else
        {
          cat("Skipping empty line\n")
        }
    }

  ## Add monitors
  if(!missing(monitor))
    for( VAR in monitor)
      newcode <- insert.function(newcode, "MONITOR",
                                 bquote(
                                        cat(.(VAR),"=",
                                            paste( .(as.name(VAR)),
                                                  collapse=",", sep="," ),
                                            "\n" )
                                        )
                                 )

  
  ## Remove place markers
  newcode <- remove.marker(newcode,
                           c("LIBS", "ASSIGNMENTS", "DENSITIES", "MONITOR"))
  
  ## Create an environment to hold the constant data
  newenv <- new.env()
  for(n in names(data))
    {
      cat("Added",n,"to the function environment.\n") 
      assign(n, data[[n]], env=newenv)
    }

  environment(newcode) <- newenv
  
  newcode
}
