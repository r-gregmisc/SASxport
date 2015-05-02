# $Id$

"lsf.get.result" <-
  function(job)
  {
    lsf.fname <- paste(job$fname, ".lsf.ret", sep="")
    if (lsf.job.status(job) != "DONE")
      return(NULL)

    if (!file.exists(lsf.fname))
      return(NULL)
    load(lsf.fname)
    if (job$debug == FALSE) {
      file.remove(job$fname)
      file.remove(lsf.fname)
    }
    lsf.ret <- get("lsf.ret")
    if (class(lsf.ret) == "try-error")
      warning("Error(s) encountered in the remote R session")
    lsf.ret
  }
