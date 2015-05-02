% trimSum.Rd
%--------------------------------------------------------------------------
% What: Sum trimmed values - help
% $Id$
% Time-stamp: <2008-12-20 00:15:57 ggorjan>
%--------------------------------------------------------------------------

\name{trimSum}

\alias{trimSum}

\title{Trim a vector such that the last/first value represents the sum of 
  trimmed values}

\description{\code{trimSum} trims (shortens) a vector in such a way that 
  the last or first value represents the sum of trimmed values. User needs
  to specify the desired length of a trimmed vector.
}

\usage{trimSum(x, n, right=TRUE, na.rm=FALSE, \dots)}

\arguments{
  \item{x}{numeric, a vector of numeric values}
  \item{n}{numeric, desired length of the output}
  \item{right}{logical, trim on the right/bottom  or the left/top  side}
  \item{na.rm}{logical, remove \code{NA} values when applying a function}
  \item{\dots}{arguments passed to other methods - currently not used}
}

\value{Trimmed vector with a last/first value representing the sum of 
  trimmed values}

\author{Gregor Gorjanc}

\seealso{\code{\link[gdata]{trim}}}

\examples{

x <- 1:10
trimSum(x, n=5)
trimSum(x, n=5, right=FALSE)

x[9] <- NA
trimSum(x, n=5)
trimSum(x, n=5, na.rm=TRUE)

}

\keyword{manip}

%--------------------------------------------------------------------------
% trimSum.Rd ends here
