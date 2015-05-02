# $Id$

lsf.apply.model <- function(fun,
                            matrix,
                            ...,
                            njobs,
                            batch.size=getOption('lsf.block.size'),
                            packages=.packages(),
                            savelist = NULL
                            )
  {
    if(missing(njobs))
      njobs <- max(1,ceiling(nrow(matrix)/batch.size))
    
    if(exists("last.warning"))  # work around R bug
      remove("last.warning", env=.GlobalEnv, inherits=FALSE)

    #
    # Test on a single row so we easily catch general errors.
    #
    args <- list( matrix[1,], ...)
    result <- do.call("fun", args)

    if(exists("last.warning", env=.GlobalEnv) )  # work around R bug
      warnings()

    #
    # Test if LSF is working
    #
    #scat("Test if LSF is working...")
    #tmp <- lsf.run.job( function() system('hostname',intern=T))
    #scat("Done.")
    #
    # Evaluate the function on all rows of the data set, distributing the
    # work across the cluster
    #

    scat("Starting paralle model fit using", njobs ,"jobs",
         "each of size",batch.size,"...")
    
    time <- system.time(
                        fits <- lsf.parRapply(
                                              matrix,
                                              fun,
                                              ...,
                                              join.method=cbind,
                                              njobs=njobs,
                                              packages=packages,
                                              savelist=savelist
                                              )
                        )
    scat("Done. Computation used", time, "")

    if(exists("last.warning", env=.GlobalEnv))  # work around R bug
      warnings()

    return(t(fits))

  }

