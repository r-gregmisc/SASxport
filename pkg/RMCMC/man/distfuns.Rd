\name{distfuns}
\alias{distfuns}
\docType{data}
\title{Distribution functions availalbe for MCMC}
\description{
  Distribution functions availalbe for MCMC
}
\usage{data(distfuns)}
\format{
  The format is: a list of lists, one component per distribution.
  Each distribution element is a list containing the following elements:
  \item{aliases}{List of names for this distribution. For the univariat
    normal this is \code{c("N", "Norm", "Normal", "Gaussian")}.}
  \item{random}{Name of the random generator for this distribution. E.G.
    "rnorm"}
  \item{density}{Density function for this distribution.  E.G. "dnorm"}
  \item{logdensity}{Log-Density function for this distribution.
    E.G. "log.dnorm"}
  \item{package}{Name(s) of package(s) which contain the functions
    listed in \code{random}, \code{density}, and \code{logdensity}.}
  }
}
\details{
  This list is intended to be extendable by users.  Please forward 
  additions which are of general interest to the author for inclusion in
  future versions of the package.
}
\examples{
data(distfuns)
str(distfuns)

# Add a new dummy distribution

}
\keyword{datasets}
