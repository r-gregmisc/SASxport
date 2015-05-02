% $Id$

\name{lsf.submit}
\alias{lsf.submit}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Submit an \R function to run through LSF}
\description{
  Submit an \R function to run in batch through the LSF distributed
  queuing environment.
}
\usage{
lsf.submit(func, ..., savelist = c(), packages = NULL, ncpus = 1,
           debug = FALSE)
}
\arguments{
  \item{func}{This argument provides the name of the function that will
    be run through LSF. It must be defined within the current scope.}
  \item{\dots}{Any arguments to \code{func} should be passed after the
    function name. They must be within the current scope, and must be
    provided to the remote function call as part of the
    \code{savelist}} 
  \item{savelist}{Chacacter vector giving the names of local objects
    that should be copied to each worker process before computation is
    started.}
  \item{packages}{List of library packages to be loaded by each worker
    process before computation is started.}
  \item{ncpus}{A number indicating how many cpus should be allocted to
    the function call. Used in conjunction with the snow and Rmpi
    packages (see notes).}
  \item{debug}{An argument which indicates whether function debugging
    should be turned on.}
}
\details{
  This function takes an \R function plus arguments, and submits the
  function to run as a batch job within the LSF distributed queuing
  environment.

  The function will store the environment specified in \code{savelist}
  within a temporary Rdata file, which will then be used on a remote
  host to restore the \R environment for the function call.

  Since \code{func} is run asynchronously, the result of the
  \code{lsf.submit} is not the result of \code{func}. In order to
  retrieve the result, the \code{lsf.get.result} function must be
  used. If synchronous execution is desired, use the \code{lsf.run.job}
  function. 
}
\value{
  \item{jobid}{The job identifier returned from LSF.}
  \item{fname}{The file name of the environment passed to the remote
    function call.}
  \item{debug}{A boolean flag indicating whether debugging should be
    turned on or not. If debugging is turned on, then the standard
    output and standard error of the remote \R process invocation will be
    placed in a file named Rlsf\_job\_output.<jobid>, where jobid is the
    same as the LSF job id returned by \code{lsf.submit}}
}
\author{Chris Smith \email{csmith@platform.com}}
\note{When submitting parallel jobs (i.e. \code{ncpus} greater than 1),
  the Rlsf package will utilize the snow and Rmpi packages for managing
  the parallel job. At this time, no other parallel packages are
  supported (e.g. snow with PVM).} 
\seealso{\code{\link{lsf.job.status}},\code{\link{lsf.get.result}},
\code{\link{lsf.run.job}}} 
\examples{

   # define some variables
   a <- 2
   b <- 3
   
   # define the function to remotely run
   myfunc <- function(x,y) { x + y }

   # submit the function to run in batch
   job <- lsf.submit(myfunc, a, b, savelist=c("a", "b"))

}
\keyword{utilities}
