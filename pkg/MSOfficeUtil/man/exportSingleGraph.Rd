\name{exportSingleGraph}
\alias{exportSingleGraphToWord}
\alias{exportSingleGraphToPowerPoint}
\title{MSOfficeUtil utility functions}
\description{Not meant to be called directly by user.}
\usage{
  exportSingleGraphToPowerPoint(p, slides, theme, ...)
  exportSingleGraphToWord(p, theme, ...)
}
\arguments{
  \item{p}{An object of class "lattice". }
  \item{slides}{The Visual Basic variable containing the slides of
    the open PowerPoint document. }
  \item{theme}{Lattice theme.  See lset() or lattice.par.get() for
    details. }
  \item{...}{Optional arguments}
}
%\details{
%}
%\value{
%}
%\examples{
%}
\author{Steven Novick <steven.j.novick@gsk.com>}
\keyword{IO}
