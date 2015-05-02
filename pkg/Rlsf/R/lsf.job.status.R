# $Id$

"lsf.job.status" <-
  function(job)
  {
    .Call("lsf_job_status", as.integer(job$jobid), PACKAGE="Rlsf")
  }
