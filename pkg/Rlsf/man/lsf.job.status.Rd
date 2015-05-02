\name{lsf.job.status}
\alias{lsf.job.status}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Check the status of a function evaluated through LSF.}
\description{
  Check the status of a function evaluated through LSF.
}
\usage{
lsf.job.status(job)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{job}{The list returned from a previous call to
    \code{lsf.submit}} 
}
\details{
  \code{lsf.job.status} will return a string representing the state of
  a function evaluated through LSF (from a previous call to
  \code{lsf.submit}). 
}
\value{
  Returns a string representation of the state of the LSF job
  (e.g. "PEND", "RUN", "DONE"). The possible states returned from
  \code{lsf.job.status} are described in the manual page for the LSF
  bjobs command. 
}
\author{Chris Smith \email{csmith@platform.com}}
\seealso{\code{\link{lsf.submit}}}
\examples{

   # define the function to remotely run
   myfunc <- function() { 2+3 }

   # submit the function to run in batch
   job <- lsf.submit(myfunc)

   # check for the status of the job
   lsf.job.status(job)

}  
\keyword{utilities}

