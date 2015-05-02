\name{ttest.matrix}
\alias{t.test.matrix}
\alias{ttest.matrix}
\title{Compute running t-tests}
\description{
  Compute a running pooled t-test
}
\usage{
ttest.matrix(ctr, trt)
t.test.matrix(ctr, trt)
}
\arguments{
  \item{ctr}{ matrix of control samples, 1 sample per column, 1
    variable per row }
  \item{trt}{ matrix of treatment samples, 1 sample per column, 1
    variable per row }
}
\details{
  This function applies a pooled variance t-test 'sequentially' to the control and
  treatment values specified in order to experimentally test the power
  of the t-test at various sample sizes.  IE, it efficiently performs
  the equivalent of
  \enumerate{
    \item{1}{ t.test( ctr[1:2], trt[1:2] ) }
    \item{2}{ t.test( ctr[1:3], trt[1:3] ) }
    \item{3}{ t.test( ctr[1:4], trt[1:4] ) }
    \item{\code{ncol(ctr)-1}}{ t.test( ctr[1:ncol(ctr)], trt[1:ncol(trt)]) }
  }
  
}
\value{
  Matrix of p-values of dimension \code{nrow(x)} by \code{(ncol(x)-1)}
}
\author{ Peng Liu \email{peng\_liu@groton.pfizer.com}}
%\seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }
\examples{
  x <- rbind(V1=rnorm(20, mean=0, sd=1),
             V2=rnorm(20, mean=0, sd=2))
  y <- rbind(V1=rnorm(20, mean=0.25, sd=1),
             V2=rnorm(20, mean=0.25, sd=2))

  ttest.matrix(x,y)
}
\keyword{htest}
