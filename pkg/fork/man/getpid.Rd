% $Id$
\name{getpid}
\alias{getpid}
\title{Obtain the process id for the current process.}
\description{
  Obtain the process number for the current process.
}
\usage{
getpid()
}
\details{
  This function is a simple wrapper around the Unix "getpid" function call.
}
\value{
  Integer process id.
}
\references{Unix "getpid" man page}
\author{ Gregory R. Warnes \email{greg@warnes.net}}
\seealso{\code{\link{fork}}, \code{\link{exit}}, \code{\link{wait}},
         \code{\link{kill}}, \code{\link{killall}} }
\examples{

getpid()

\dontrun{
for(i in 1:10)
  fork( function() { cat("PID:", getpid(), "\n"); exit()} )
}
}
\keyword{programming}
