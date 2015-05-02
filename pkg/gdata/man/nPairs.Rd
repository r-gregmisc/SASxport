% nPairs.Rd
%--------------------------------------------------------------------------
% What: Number of variable pairs - help
% $Id$
% Time-stamp: <2008-12-30 18:30:11 ggorjan>
%--------------------------------------------------------------------------

\name{nPairs}

\alias{nPairs}

\concept{pairs}

\title{Number of variable pairs}

\description{

\code{nPairs} counts the number of pairs between variables.

}

\usage{
nPairs(x, margin=FALSE, names=TRUE, abbrev=TRUE, ...)
}

\arguments{
  \item{x}{data.frame or a matrix}
  \item{margin}{logical, calculate the cumulative number of \dQuote{pairs}}
  \item{names}{logical, add row/col-names to the output}
  \item{abbrev}{logical, abbreviate names}
  \item{\dots}{other arguments passed to \code{\link{abbreviate}}}
}

\details{

The class of returned matrix is nPairs and matrix. There is a summary method,
which shows the opposite information - counts how many times each variable is 
known, while the other variable of a pair is not. See examples.

}

\value{

Matrix of order \eqn{k}, where \eqn{k} is the number of columns in \code{x}.
Values in a matrix represent the number of pairs between columns/variables in
\code{x}. If \code{margin=TRUE}, the number of columns is \eqn{k+1} and the
last column represents the cumulative number of pairing all variables.

}

\author{Gregor Gorjanc}

\seealso{\code{\link{abbreviate}}}

\examples{

## Test data
test <- data.frame(V1=c(1, 2, 3, 4, 5),
                   V2=c(NA, 2, 3, 4, 5),
                   V3=c(1, NA, NA, NA, NA),
                   V4=c(1, 2, 3, NA, NA))

## Number of variable pairs
nPairs(x=test)

## Without names
nPairs(x=test, names=FALSE)

## Longer names
colnames(test) <- c("Variable1", "Variable2", "Variable3", "Variable4")
nPairs(x=test)

## Margin
nPairs(x=test, margin=TRUE)

## Summary
summary(object=nPairs(x=test))
}

\keyword{misc}

%--------------------------------------------------------------------------
% nPairs.Rd ends here
