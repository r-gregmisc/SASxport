
                                        # $Id$

lsf.parCapply <- function(x, ...)
  lsf.parRapply( t(x), ...)


lsf.parRapply <- function (x, fun, ...,
                           join.method=cbind,
                           njobs,
                           batch.size=getOption('lsf.block.size'),
                           trace=TRUE,
                           packages=NULL,
                           savelist=NULL
                           )
  {
    if(missing(njobs))
      njobs <- max(1,ceiling(nrow(x)/batch.size))
    
    if(!is.matrix(x) && !is.data.frame(x))
      stop("x must be a matrix or data frame")


    # The version in snow of splitrows uses 'F' instead of 'FALSE' and
    # so, causes errors in R CMD check
    lsf.splitRows <- function (x, ncl) 
      lapply(splitIndices(nrow(x), ncl), function(i) x[i, , drop = FALSE])
    
    if(njobs>1)
      rowSet <- lsf.splitRows(x, njobs)
    else
      rowSet <- list(x)
    
    if(trace) cat("Submitting ", njobs, "jobs...")
    jobs <- lapply( rowSet,
                    function(x) lsf.submit(apply,
                                           X=x, MARGIN=1, FUN=fun, ...,
                                           savelist=savelist,
                                           packages=packages)
                   )
    if(trace) cat("Done\n")
    done <- FALSE
    while(!done)
      {
        if(trace) cat("Waiting 5s for jobs to complete...")
        Sys.sleep(5)
        if(trace) cat("Done.\n")
        
        status <- sapply( jobs, lsf.job.status)
        status <- sapply( status, function(x) if(is.null(x)) "UNKWN" else x)

        if(trace) cat("Current status:\n")
        statusTable <- as.matrix(table(status))
        statusTable <- data.frame("N"=statusTable,
                                  "%"=formatC(statusTable/njobs, format="f",
                                              width=4, digits=2),
                                  check.names=FALSE)
        if(trace) print(statusTable)
        done <- all(status %in% c("DONE","EXIT","ZOMBI","UNKWN") )
      }
    
    results <- lapply( jobs, lsf.get.result )

    retval <- docall(join.method, results)

    retval
  }
