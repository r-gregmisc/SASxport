\name{lsf.control.job}
\alias{lsf.kill.job}
\alias{lsf.suspend.job}
\alias{lsf.resume.job}
\title{Control a job that was submitted to LSF}
\description{
  Manage a job which has been previously submitted to LSF using the
  \code{lsf.submit} function. Control actions include the termination
  of the job, the suspension of a running job, and the resumption of a
  suspended job. 
}
\usage{
lsf.kill.job(job)
lsf.suspend.job(job)
lsf.resume.job(job)
}
\arguments{
  \item{job}{The list returned from a previous call to
    \code{lsf.submit}} 
}
\details{
  \code{lsf.kill.job} will ask LSF to terminate a job that was
  previously submitted using \code{lsf.submit}.

  \code{lsf.suspend.job} will ask LSF to suspend a job (i.e. send it a
  stop signal) that was previously submitted using
  \code{lsf.submit}.

  \code{lsf.resume.job} will ask LSF to resume a job that had
  previously been suspended using the \code{lsf.suspend.job} function. 
}
\value{
  Returns 0 if the control request was sent successfully, and -1 if
  there was an error sending the request. 
}
\author{Chris Smith \email{csmith@platform.com}}
\note{When LSF control functions are called, the call represents a
  request to take the action. Depending on the configuration of LSF,
  the actual action taken is not pre-defined. For example, LSF can be
  configured to send a different signal from the default SIGSTOP in
  order to suspend a job. If this different signal is sent by LSF, but
  the job ignores the signal, then the job is not actually
  stopped. There are similar configuration overrides for both
  termination and resumption of jobs.}
\seealso{\code{\link{lsf.submit}}}
\examples{

   # define the function to remotely run
   myfunc <- function() { 2+3 }

   # submit the function to run in batch
   job <- lsf.submit(myfunc)

   # check if the job is in the "RUN" state
   lsf.job.status(job)

   # when job is in RUN state, suspend it
   lsf.suspend.job(job)

   # check to see if the job is in "USUSP" state
   lsf.job.status(job)

   # when job is in "USUSP" state, resume it
   lsf.resume.job(job)

   # check that job is back in the "RUN" state.
   # Might take a minute or two for signal to propagate.
   lsf.job.status(job)

   # when job is running, kill it
   lsf.kill.job(job)

   # the job should be in "DONE" or "EXIT" state
   lsf.job.status(job)

}  
\keyword{utilities}

