% $Id$
\name{exit}
\alias{exit}
\title{Exit from a child process}
\description{
  Exit from a child process.
}
\usage{
exit(status = 0)
}
\arguments{
  \item{status}{Integer status flag. Use 0 for a normal exit.}
}
\details{
  This function is a shallow warpper adound the Unix "\_exit" command,
  and should be used instead of \code{quit()} to exit from a  process
  created via \code{fork}.
}
\value{
  None.
}
\note{
  The \code{fork} command automatically sets up an  \code{on.exit}
  function that calls \code{exit} before evaluating the \code{slave}
  argument, so it is usually not necessary to directly call exit().
  }
\references{"\_exit" man page}
\author{ Gregory R. Warnes \email{greg@warnes.net}}
\seealso{\code{\link{fork}}, \code{\link{getpid}}, \code{\link{wait}},
         \code{\link{kill}}, \code{\link{killall}} }
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

