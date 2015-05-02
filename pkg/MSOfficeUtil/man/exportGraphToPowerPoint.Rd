\name{exportGraphToPowerPoint}
\alias{exportGraphToPowerPoint}
\title{Export Graph(s) to MS-PowerPoint}
\description{Export one or more lattice graph(s) to MS-PowerPoint.}
\usage{exportGraphToPowerPoint(object, file.name, overwrite=TRUE, ...)}
\arguments{
  \item{object}{ A list of lattice graphs. }
  \item{file.name}{ String with full path and PowerPoint file name. }
  \item{overwrite}{ If the file exists and overwrite is FALSE, will
    append graphs to the end of the PowerPoint document.  Otherwise, it
    will erase the file (or create it).}
  \item{...}{Optional arguments}
}
%\details{
%}
%\value{
%}
\examples{
  p1 = xyplot(rnorm(10)~1:10, main="Plot 1")
  p2 = xyplot(rnorm(10)~(-10:(-1)), col="red", type="l",
        main="Plot 2", xlab="Hi there")

  exportGraphToPowerPoint(list(p1, p2), "C:/MyTest1.ppt")
  
  lset()  ## For a white background.
  exportGraphToPowerPoint(list(p1, p2), "C:/MyTest2.ppt")
}
\author{Steven Novick <steven.j.novick@gsk.com>}
\keyword{IO}
