/* $Id$ */

#include <lsf/lsbatch.h>
#include <R.h>
#include <Rdefines.h>
#include <R_ext/PrtUtil.h>

SEXP AsInt(int);

SEXP
lsf_initialize(void)
{
  if (lsb_init("R")) {
    Rprintf("lsf_initialize: lsb_init: %s\n", lsb_sysmsg());
    return AsInt(-1);
  }
  else {
    return AsInt(0);
  } 
}

SEXP
lsf_job_submit(SEXP sexp_debug, SEXP sexp_command, SEXP sexp_ncpus)
{
  int jobId, debug, i;
  struct submit submitRequest;
  struct submitReply submitReply;

  debug = INTEGER(sexp_debug)[0];
  memset(&submitRequest, 0, sizeof(submitRequest));
  for (i = 0; i < LSF_RLIM_NLIMITS; i++)
    submitRequest.rLimits[i] = DEFAULT_RLIMIT;
  submitRequest.command = CHAR(STRING_ELT(sexp_command, 0));
  submitRequest.options |= SUB_OUT_FILE;
  if (debug) {
    submitRequest.outFile = "Rlsf_job_output.%J";
  } else {
    submitRequest.outFile = "/dev/null";
  }
  submitRequest.numProcessors = INTEGER(sexp_ncpus)[0];
  submitRequest.maxNumProcessors = INTEGER(sexp_ncpus)[0];

  if (setenv("BSUB_QUIET", "1", 1)) {
    return AsInt(0);
  }
  jobId = lsb_submit(&submitRequest, &submitReply);
  if (jobId == -1) {
    Rprintf("lsf_job_submit: lsb_submit: %s\n", lsb_sysmsg());
    return AsInt(0);
  }

  return AsInt(jobId);
}

SEXP
lsf_job_status(SEXP sexp_jobid)
{
  int jobid, numrec;
  struct jobInfoEnt *jInfo;
  SEXP status;

  jobid = INTEGER(sexp_jobid)[0];
  
  if ((numrec = lsb_openjobinfo(jobid, NULL, NULL, NULL, NULL, ALL_JOB)) < 0) {
    Rprintf("lsf_job_status: lsb_openjobinfo: %s\n", lsb_sysmsg());
    return R_NilValue;
  }

  jInfo = lsb_readjobinfo(&numrec);
  if (jInfo == NULL) {
    Rprintf("lsf_job_status: lsb_readjobinfo: %s\n", lsb_sysmsg());
    lsb_closejobinfo();
    return R_NilValue;
  }

  lsb_closejobinfo();
  
  PROTECT(status = allocVector(STRSXP, 1));
  switch(jInfo->status) {
  case JOB_STAT_NULL:
    SET_STRING_ELT(status, 0, mkChar("NULL"));
    break;
  case JOB_STAT_PEND:
    SET_STRING_ELT(status, 0, mkChar("PEND"));
    break;
  case JOB_STAT_PSUSP:
    SET_STRING_ELT(status, 0, mkChar("PSUSP"));
    break;
  case JOB_STAT_RUN:
    SET_STRING_ELT(status, 0, mkChar("RUN"));
    break;
  case JOB_STAT_RUN|JOB_STAT_WAIT:
    SET_STRING_ELT(status, 0, mkChar("WAIT"));
    break;
  case JOB_STAT_SSUSP:
    SET_STRING_ELT(status, 0, mkChar("SSUSP"));
    break;
  case JOB_STAT_USUSP:
    SET_STRING_ELT(status, 0, mkChar("USUSP"));
    break;
  case JOB_STAT_EXIT:
    if (jInfo->reasons & EXIT_ZOMBIE)
      SET_STRING_ELT(status, 0, mkChar("ZOMBI"));
    else
      SET_STRING_ELT(status, 0, mkChar("EXIT"));
    break;
  case JOB_STAT_DONE:
  case JOB_STAT_DONE|JOB_STAT_PDONE:
  case JOB_STAT_DONE|JOB_STAT_PERR:
  case JOB_STAT_DONE|JOB_STAT_WAIT:
    SET_STRING_ELT(status, 0, mkChar("DONE"));
    break;
  case JOB_STAT_UNKWN:
    SET_STRING_ELT(status, 0, mkChar("UNKWN"));
    break;
  default:
    Rprintf("lsf_job_status: job state <%d> is unknown.\n", jInfo->status);
    SET_STRING_ELT(status, 0, mkChar("ERROR"));
    break;
  }
  UNPROTECT(1);

  return status;
}
  
  

SEXP
AsInt(int x)
{
  SEXP sexp_x;
  PROTECT(sexp_x = allocVector(INTSXP, 1));
  INTEGER(sexp_x)[0] = x;
  UNPROTECT(1);
  return sexp_x;
}

SEXP
showArgs(SEXP args)
{
  int i, nargs;
  char *name;
  Rcomplex cpl;

  if ((nargs = length(args) - 1) > 0) {
    for (i = 0; i < nargs; i++) {
      args = CDR(args);
      name = CHAR(PRINTNAME(TAG(args)));
      switch (TYPEOF(CAR(args))) {
      case REALSXP:
	Rprintf("[%d] '%s' %f\n", i+1, name, REAL(CAR(args))[0]);
	break;
      case LGLSXP:
      case INTSXP:
	Rprintf("[%d] '%s' %d\n", i+1, name, INTEGER(CAR(args))[0]);
	break;
      case CPLXSXP:
	cpl = COMPLEX(CAR(args))[0];
	Rprintf("[%d] '%s' %f + %fi\n", i+1, name, cpl.r, cpl.i);
	break;
      case STRSXP:
	Rprintf("[%d] '%s' %s\n", i+1, name, CHAR(STRING_ELT(CAR(args), 0)));
	break;
      default:
	Rprintf("[%d] '%s' R type\n", i+1, name);
      }
    }
  }
  return R_NilValue;
}

SEXP
lsf_kill_job(SEXP sexp_jobid)
{
  int jobid, rc;

  jobid = INTEGER(sexp_jobid)[0];

  rc = lsb_signaljob(jobid, SIGKILL);
  
  if (rc < 0) {
    Rprintf("lsf_kill_job: lsb_signaljob: %s\n", lsb_sysmsg());
    return AsInt(-1);
  }
  
  return AsInt(0);
}

SEXP
lsf_suspend_job(SEXP sexp_jobid)
{
  int jobid, rc;

  jobid = INTEGER(sexp_jobid)[0];

  rc = lsb_signaljob(jobid, SIGSTOP);
  
  if (rc < 0) {
    Rprintf("lsf_suspend_job: lsb_signaljob: %s\n", lsb_sysmsg());
    return AsInt(-1);
  }
  
  return AsInt(0);
}

SEXP
lsf_resume_job(SEXP sexp_jobid)
{
  int jobid, rc;

  jobid = INTEGER(sexp_jobid)[0];

  rc = lsb_signaljob(jobid, SIGCONT);
  
  if (rc < 0) {
    Rprintf("lsf_resume_job: lsb_signaljob: %s\n", lsb_sysmsg());
    return AsInt(-1);
  }
  
  return AsInt(0);
}


