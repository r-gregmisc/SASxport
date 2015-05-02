\name{lsf.get.result}
\alias{lsf.get.result}
\title{Get the result of a function run through LSF}
\description{
  Retrieve the function result from the asynchronous execution of an \R
  function through LSF. 
}
\usage{
lsf.get.result(job)
}
\arguments{
  \item{job}{The list returned from a previous call to
    \code{lsf.submit}} 
}
\details{
  This function will retrieve the result of the function provided as an
  argument to \code{lsf.submit}. Since \code{lsf.submit} runs
  asynchronously, the result must be explicitly requested.
}
\value{
  This function returns the result of the remote invocation of the
  \code{func} argument to the \code{lsf.submit} call, or will return
  NULL if there is no result available at the time of the call (the
  result can only be retrieved when \code{lsf.job.status} returns
  "DONE".

  The function is invoked remotely using the \code{try} function. If
  there is an error invoking the submitted function, an object of class
  "try-error" containing the error message will be returned. 
}
\author{Chris Smith \email{csmith@platform.com}}
\seealso{\code{\link{lsf.submit}}, \code{\link{lsf.job.status}},
\code{\link{try}}}
\examples{

   # define the function to remotely run
   myfunc <- function() { 2+3 }

   # submit the function to run in batch
   job <- lsf.submit(myfunc)

   # check if the job is finished yet
   lsf.job.status(job)

   # retrieve the result of myfunc
   # should only be called when lsf.job.status returns 'DONE' 
   res <- lsf.get.result(job)

}
\keyword{utilities}

