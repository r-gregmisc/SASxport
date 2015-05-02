% $Id$
%
\name{fast.prcomp}
\alias{fast.prcomp}
\alias{fast.svd}
\title{Efficient computation of principal components and singular value
  decompositions.}
\description{
  The standard \code{\link[stats]{prcomp}} and \code{\link{svd}}
  function are very inefficient for wide matrixes. \code{fast.prcomp}
  and \code{fast.svd} are modified versions which are efficient even
  for matrixes that are very wide.
}
\usage{
  fast.prcomp(x, retx = TRUE, center = TRUE, scale. = FALSE, tol = NULL)
  fast.svd( x, nu = min(n, p), nv = min(n, p), ...) 
}
\arguments{
  \item{x}{data matrix}
  \item{retx, center, scale., tol}{ See documetation for
    \code{\link[stats]{prcomp}}
  }
  \item{nu, nv, ...}{ See documetation for \code{\link{svd}} }
}
\details{
 The current implementation of the function \code{\link{svd}} in S-Plus
 and R is much slower when operating on a matrix with a large number of
 columns than on the transpose of this matrix, which has a large
 number of rows. As a consequence, \code{\link[stats]{prcomp}}, which uses
 \code{\link{svd}}, is also very slow when applied to matrixes with a
 large number of rows.
 
 For R, the simple solution is to use \code{\link{La.svd}} instead of
 \code{\link{svd}}.  A suitable patch to \code{\link[stats]{prcomp}} has
 been submitted.  In the mean time, the function \code{fast.prcomp} has
 been provided as a short-term work-around.

 For S-Plus the solution is to replace the standard \code{\link{svd}}
 with a version that checks the dimensions of the matrix, and performs
 the computation on the transposed the matrix if it is wider than tall.

 For R:
 \describe{
   \item{\code{fast.prcomp}}{is a modified versiom of
     \code{\link[stats]{prcomp}} that calls \code{\link{La.svd}} instead
     of \code{\link{svd}}
   }
   \item{\code{fast.svd}}{is simply a wrapper around \code{\link{La.svd}}.
   }
 }

 For S-Plus:
 \describe{
   \item{\code{fast.prcomp}}{is a modified versiom of
     \code{\link{prcomp}} that calls \code{fast.svd} instead
     of \code{\link{svd}}
   }
   \item{\code{fast.svd}}{checks the dimensions of the
     matrix.  When it is wider than tall, it transposes the input matrix
     and calls \code{\link{svd}}.  It then swaps \code{u} and \code{v}
     and returns the result.  Otherwise, it just calls \code{\link{svd}}
     and returns the results unchanged.
   }
 }

}
\value{
  See the documetation for \code{\link[stats]{prcomp}} or 
  \code{\link{svd}} .
}
\author{Modifications by Gregory R. Warnes
  \email{greg@warnes.net} }

\seealso{
    \code{\link[stats]{prcomp}}, \code{\link{svd}}, \code{\link{La.svd}}
}

\examples{

  # create test matrix
  set.seed(4943546)
  nr <- 50
  nc <- 2000
  x  <- matrix( rnorm( nr*nc), nrow=nr, ncol=nc )
  tx <- t(x)

  # SVD directly on matrix is SLOW:
  system.time( val.x <- svd(x)$u )

  # SVD on t(matrix) is FAST:
  system.time( val.tx <- svd(tx)$v )

  # and the results are equivalent:
  max( abs(val.x) - abs(val.tx) )

  # Time gap dissapears using fast.svd:
  system.time( val.x <- fast.svd(x)$u )
  system.time( val.tx <- fast.svd(tx)$v )
  max( abs(val.x) - abs(val.tx) )


  library(stats)

  # prcomp directly on matrix is SLOW:
  system.time( pr.x <- prcomp(x) )

  # prcomp.fast is much faster
  system.time( fast.pr.x <- fast.prcomp(x) )

  # and the results are equivalent
  max( pr.x$sdev - fast.pr.x$sdev )
  max( abs(pr.x$rotation[,1:49]) - abs(fast.pr.x$rotation[,1:49]) )
  max( abs(pr.x$x) - abs(fast.pr.x$x)  )

  # (except for the last and least significant component):
  max( abs(pr.x$rotation[,50]) - abs(fast.pr.x$rotation[,50]) )
}
\keyword{multivariate}
\keyword{algebra}
\keyword{array}

