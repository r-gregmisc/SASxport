# $Id$

"lsf.run.job" <-
  function(func, ..., savelist=c(), packages=NULL, ncpus=1, debug=FALSE,
           interval=15)
  {
    job <- lsf.submit(func, ..., savelist=savelist, ncpus=ncpus, debug=debug)
    if (is.null(job)) {
      scat("lsf.run.job: Could not submit job to LSF.\n")
      return(NULL)
    }

    repeat {
      state <- lsf.job.status(job)
      if (is.null(state)) {
        scat("lsf.run.job: unknown error retrieving job state.\n")
        return(NULL)
      }
      
      if (state == "NULL"
          || state == "ZOMBI"
          || state == "UNKWN"
          || state == "ERROR") {
        scat("lsf.run.job: job is in an error state.\n")
        return(NULL)
      }

      if (state == "EXIT") {
        scat("lsf.run.job: job did not complete successfully ... no results\n")
        return(NULL)
      }

      if (state == "DONE")
        return(lsf.get.result(job))

      Sys.sleep(interval)
    }
  }
    
