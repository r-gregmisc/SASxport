% wideByFactor.Rd
%--------------------------------------------------------------------------
% What: Reshape by factor levels - help
% $Id$
% Time-stamp: <2008-12-30 13:49:50 ggorjan>
%--------------------------------------------------------------------------

\name{wideByFactor}
\alias{wideByFactor}

\title{Create multivariate data by a given factor}

\description{
  
\code{wideByFactor} modifies data.frame in such a way that variables are
\dQuote{separated} into several columns by factor levels.

}

\usage{
  wideByFactor(x, factor, common, sort=TRUE, keepFactor=TRUE)
}

\arguments{
  \item{x}{data frame}
  \item{factor}{character, column name of a factor by which variables will 
    be divided}
  \item{common}{character, column names of (common) columns that should not
    be divided}
  \item{sort}{logical, sort resulting data frame by factor levels}
  \item{keepFactor}{logical, keep the \sQuote{factor} column}
}

\details{

Given data frame is modified in such a way, that output represents a data frame 
with \eqn{c + f + n * v} columns, where \eqn{c} is a number of common columns 
for all levels of a factor, \eqn{f} is a factor column, \eqn{n} is a number of 
levels in factor \eqn{f} and \eqn{v} is a number of variables that should be 
divided for each level of a factor. Number of rows stays the same!
}

\value{
  A data frame where divided variables have sort of \dQuote{diagonalized} structure 
}

\author{Gregor Gorjanc}

\seealso{ 
  \code{\link[stats]{reshape}} in the \pkg{stats} package,
  \code{\link[reshape]{melt}} and \code{\link[reshape]{cast}} in 
  the \pkg{reshape} package
}

\examples{
n <- 10
f <- 2
tmp <- data.frame(y1=rnorm(n=n),
                  y2=rnorm(n=n),
                  f1=factor(rep(letters[1:f], n/2)),
                  f2=factor(c(rep(c("M"), n/2), rep(c("F"), n/2))),
                  c1=1:n,
                  c2=2*(1:n))

wideByFactor(x=tmp, factor="f1", common=c("c1", "c2", "f2"))
wideByFactor(x=tmp, factor="f1", common=c("c1", "c2"))
}

\keyword{manip}
\keyword{misc}

%--------------------------------------------------------------------------
% wideByFactor.Rd ends here