# $Id$

"lsf.resume.job" <-
  function(job)
  {
    .Call("lsf_resume_job", as.integer(job$jobid), PACKAGE="Rlsf")
  }
