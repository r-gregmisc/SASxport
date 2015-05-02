% $Id$
\name{wait}
\alias{wait}
\title{Wait for child process(es) to stop or terminate.}
\description{
  Wait for child process(es) created using 'fork' command to
  stop or terminate.
}
\usage{
wait(pid, nohang=FALSE, untraced=FALSE)
}
\arguments{
  \item{pid}{integer indicating the set of child processes  for
    which status is requested.  If missing or \code{NULL}, wait
    for all child processes.}
  \item{nohang}{Use the WNOHANG flag.}
  \item{untraced}{Use the WUNTRACED flag.}
}
\details{
  This function provides a thin wrapper around the Unix "wait" and
  "waitpid" system calls.   If \code{pid} is missing or \code{NULL}
  call, "wait" is called, otherwise "waitpid" is called.

  Refer to the local Unix man pages for details on these system calls
  and the meanings of the various flags.
  
}
\value{
  A vector of length 2 containing 
  \item{pid}{Process id of a child process}
  \item{status}{Status of the child process.}

  Refer to the local Unix man pages for details on these system calls
  and the meanings of the status indicator.
}
\references{"wait" and "waitpid"  man pages}
\author{ Gregory R. Warnes \email{greg@warnes.net}}
\seealso{\code{\link{fork}}, \code{\link{exit}}, \code{\link{getpid}},
         \code{\link{kill}}, \code{\link{killall}}}
\examples{
waittest <- function()
{ 
  pid = fork(NULL)
  if(pid==0)
    {
      cat("Hi, I'm the child process and I need to explicitly call exit().")
      cat("\n\n")
      exit()
    }
  else
    {
      wait(pid)
      cat("Hi, I'm the main process, and I wait()ed until the child process\n")
      cat("finished before introducing myself.\n")
    }
}

waittest()
}
\keyword{programming}
