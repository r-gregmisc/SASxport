\name{handleSIGCLD}
\alias{handleSIGCLD}
\alias{restoreSIGCLD}
\title{Establish or remove a dummy handler for SIGCLD signals}
\description{
  Establish \code{handleSIGCLD} or remove \code{ignoreSIGCLD} a dummy
  handler for SIGCLD signals
}
\usage{
handleSIGCLD()
restoreSIGCLD()
}
\details{
  The \code{handleSIGCLD} function establishes a 'dummy' handler for
  SIGCLD signals. It accepts signals from exiting child processes
  created by \code{fork} and ignores them.  This prevents child
  processes from becoming 'zombies', which would occurs when the parent
  process does not handle this signal.

  The \code{restoreSIGCLD} function restores the previous (lack of)
  signal handler.
}
\value{
  No return value.
}
\note{
  The SIGCLD handling mechanism implemented by \code{handleSIGCLD}
  should prevent zombie process creation on systems derived from both
  SYSV and BSD UNIX, including Linux, Mac OSX, NetBSD, and Solaris.
  }
\references{W.R. Stevens and S.A. Rago, Advanced Programming in the UNIX
  environment, 2nd ed. (c) 2005, Pearson Education, pp 308-310.}
\author{Gregory R. Warnes \email{greg@warnes.net},
  with financial support from Metrum Research Group, LLC
  \url{http://www.metrumrg.com}.
}
\seealso{ \code{\link{fork}}, \code{\link{wait}}, \code{\link{signal}} }
\examples{

## set up the dummy signal hander
handleSIGCLD()

## Generate 100 child processes
for(i in 1:100)
  {
    pid = fork(slave=NULL) 
    if(pid==0)
      {
        ## don't do anything useful 
        exit() 
      }
  }

## remove the dummy signal handler
restoreSIGCLD()
}
\keyword{programming}

