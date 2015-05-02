# $Id$

"lsf.suspend.job" <-
  function(job)
  {
    .Call("lsf_suspend_job", as.integer(job$jobid), PACKAGE="Rlsf")
  }
