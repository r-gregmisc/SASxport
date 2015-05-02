# handles components that are unevaluated expressions, character
# strings, and quoted expressions

model <- function(...)
  {
    retval <- mycall <- match.call(expand.dots=TRUE)
    if(length(retval)==2 && retval[[1]]=="model")
      {
        # if we were passed a model, return it unchanged
        retval <- (...)  
      }
    else
      {
        # convert character strings and explicit expressions
        modes <- sapply(retval,mode)
        exprs <- sapply(retval, is.expression)

        calls <- sapply(retval, function(X) try(X[[1]], silent=T))

        convert <- which( (modes %in% c("character")) | calls=="expression" |
                         exprs)
        
        for(i in convert)
          {
            new <- eval(parse(text=paste("quote(",
                                gsub("expression\\((.*)\\)","\\1",
                                     sub("=", "<-",retval[i])),
                                ")")))
            retval[[i]] <- new
          }

        # do the same for objecs of class expressions
        
        
        # convert expressions of the form
        #    LHS=RHS
        # to
        #    LHS <- RHS
        # because R eats the LHS in the first form
        if(length(names(retval))>0)
          for( i in 1:length(names(retval)) )
            {
              LHS <- names(retval)[i]
              RHS <- retval[[i]]
              if(is.character(RHS)) RHS <- parse(text=RHS)
              if(LHS>"" && LHS != "data")
                retval[[i]] <- bquote( .(as.symbol(LHS)) <- .(RHS) )
            }
        names(retval) <- rep("",length(retval))

        which <- which(names(mycall)=="data")
        if(length(which)>0)
          {
            retval[[which]] <- eval(retval[[which]])
            names(retval)[which] <- "data"
          }

      }

    class(retval) <- "model"
    
    retval
  }

