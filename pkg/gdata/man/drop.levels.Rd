% $Id$

\name{drop.levels}
\alias{drop.levels}
\title{Drop unused factor levels}
\description{Drop unused levels in a factor}
\usage{
drop.levels(x, reorder=TRUE, ...)
}
\arguments{
  \item{x}{object to be processed}
  \item{reorder}{should factor levels be reordered using
    \code{\link{reorder.factor}}?}
  \item{...}{additional arguments to \code{\link{reorder.factor}}}
}

\details{

\code{drop.levels} is a generic function, where default method does
nothing, while method for factor \code{s} drops all unused levels. Drop
is done with \code{x[, drop=TRUE]}.

There are also convenient methods for \code{list} and \code{data.frame},
where all unused levels are dropped in all factors (one by one) in a
\code{list} or a \code{data.frame}.

}

\value{Input object without unused levels.}

\author{Jim Rogers \email{james.a.rogers@pfizer.com} and Gregor Gorjanc}

\examples{

f <- factor(c("A", "B", "C", "D"))[1:3]
drop.levels(f)

l <- list(f=f, i=1:3, c=c("A", "B", "D"))
drop.levels(l)

df <- as.data.frame(l)
str(df)
str(drop.levels(df))

}

\keyword{manip}
