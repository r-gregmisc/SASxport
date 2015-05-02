\name{duplicated2}
\alias{duplicated2}
\title{Determine Duplicate Elements}
\description{
  \code{duplicated2()} determines which elements of a vector or data 
  frame are duplicates, and returns a logical vector indicating which 
  elements (rows) are duplicates.
}
\usage{
duplicated2(x, bothWays=TRUE, ...)
}
\arguments{
  \item{x}{a vector or a data frame or an array or \code{NULL}.}
  \item{bothWays}{if \code{TRUE} (the default), duplication should be 
    considered from both sides. For more information see the argument \code{fromLast}
    to the function \code{\link{duplicated}}.}
  \item{\dots}{further arguments passed down to \code{duplicated()} and
    its methods.}
}
\details{
  The standard \code{\link{duplicated}} function (in \code{package:base}) 
  only returns \code{TRUE} for the second and following copies of each
  duplicated value (second-to-last and earlier when
  \code{fromLast=TRUE}).  This function returns all duplicated
  elementes, including the first (last) value.
  
  When \code{bothWays} is \code{FALSE}, \code{duplicated2()} defaults to 
  a \code{\link{duplicated}} call. When \code{bothWays} is \code{TRUE}, 
  the following call is being executed: 
  \code{duplicated(x, ...) | duplicated(x, fromLast=TRUE, ...)}
}
\value{
    For a vector input, a logical vector of the same length as
    \code{x}.  For a data frame, a logical vector with one element for
    each row.  For a matrix or array, and when \code{MARGIN = 0}, a
    logical array with the same dimensions and dimnames.
    
    For more details see \code{\link{duplicated}}.
}
\seealso{
  \code{\link[base]{duplicated}}, \code{\link[base]{unique}}
}
\author{Liviu Andronic}
\examples{
  data(iris)
  iris[duplicated(iris), ]                 # 2nd duplicated value
  iris[duplicated(iris, fromLast=TRUE), ]  # 1st duplicated value
  iris[duplicated2(iris), ]                # both duplicated values
}
\keyword{logic}
\keyword{manip}
