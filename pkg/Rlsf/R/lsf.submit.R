# $Id$

"lsf.submit" <-
  function(func, ..., savelist=c(), packages=NULL, ncpus=1, debug=FALSE)
  # savelist is a character vector of *names* of objects to be
  # copied to the remote R session
  {
    fname <- tempfile(pattern = "Rlsf_data", tmpdir = getwd())

    lsf.call <- as.call(list(func, ...) )

    savelist <- c(savelist, "lsf.call", "packages")

    save(list=savelist, file=fname)

    script <- paste(file.path(.path.package("Rlsf"), "RunLsfJob"), fname)

    jobid <- .Call("lsf_job_submit",
                   as.integer(debug),
                   script,
                   as.integer(ncpus),
                   PACKAGE="Rlsf")

    if (jobid)
      list(jobid=jobid,fname=fname,debug=debug)
    else 
      return(NULL)
  }


