# $Id$

"lsf.kill.job" <-
  function(job)
  {
    .Call("lsf_kill_job", as.integer(job$jobid), PACKAGE="Rlsf")
  }
