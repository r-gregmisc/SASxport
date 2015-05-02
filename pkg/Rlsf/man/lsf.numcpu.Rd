% $Id$

\name{lsf.numcpu}
\alias{lsf.numcpu}
\title{Determine the number of CPUs assigned by LSF}
\description{
  Determine the number of CPUs assigned by LSF.
}
\usage{
lsf.numcpu()
}
\arguments{
  None.
}
\details{
  This function determines the number of hosts present in the LSB\_HOSTS
  environment variable.  If the environment variable does not exist or
  is empty, an error will be generated.
}
\value{
  The number of CPUs assigned the R process by LSF.
}
%\references{ ~put references to the literature/web site here ~ }
\author{Gregory R. Warnes \email{warnes@bst.rochester.edu}}
%\seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }
\examples{

   \testonly{
     Sys.putenv("LSB\_HOSTS"="host1 host2 host3 host4")
   }

   # get the number of cpus, fail if unable to do so
   lsf.numcpu()

}
\keyword{utilities}
