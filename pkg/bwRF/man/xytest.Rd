% $Id$

\name{xytest}
\alias{xytest}
\docType{data}
\title{Test data for bwRF package}
\description{
  Test data for bwRF package}
}
\usage{data(xytest)}
\format{
  A data frame with 140 observations on the following 3501 variables.
  \describe{
    \item{ycl}{numeric vector containing class id}
    \item{X1-X3500}{numeric vectors containing predictor values}
  }
}
% \details{
%   ~~ If necessary, more details than the __description__ above ~~
% }
% \source{
%   ~~ reference to a publication or URL from which the data were obtained ~~
% }
% \references{
%   ~~ possibly secondary sources and usages ~~
% }
\examples{
data(xytest)

jwt <- as.vector( rev(table(xytest$ycl)) ); jwt <- jwt/sum(jwt)
brf <- RF(xytest$ycl, xytest[,-1], classwt=jwt, ndsize=1, Vote=3,
          ntree=1000, nlook=170, iimp=FALSE, wGini=TRUE
          )

}
\keyword{datasets}
