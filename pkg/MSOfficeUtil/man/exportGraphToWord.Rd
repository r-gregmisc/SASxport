\name{exportGraphToWord}
\alias{exportGraphToWord}
\title{Export Graph(s) to MS-Word}
\description{Export Graph(s) to Word.}
\usage{exportGraphToWord(object, file.name, overwrite=TRUE)}
\arguments{
  \item{object}{A list of lattice graphs. }
  \item{file.name}{String with full path and Word file name. }
  \item{overwrite}{If the file exists and overwrite is FALSE, will
    append graphs to the beginning of the Word document.  Otherwise, the
    file will be overwritten.}
}
% \details{
% }
% \value{
% }
\examples{
  library(lattice)
  p1 = xyplot(rnorm(10)~1:10, main="Plot 1")
  p2 = xyplot(rnorm(10)~(-10:(-1)), col="red", type="l", main="Plot 2",
              xlab="Hi there")

  exportGraphToWord(list(p1, p2), "C:/MyTest1.doc")
  
  lset()  ## For a white background.
  exportGraphToWord(list(p1, p2), "C:/MyTest2.doc")
  
  p3 = xyplot(rnorm(10)~1:10, main="Plot 3")
  p4 = xyplot(rnorm(10)~(-10:(-1)), col="red", type="l", main="Plot 4",
              xlab="Hi there")
  exportGraphToWord(list(p1, p2), "C:/MyTest2.doc", overwrite=FALSE)
}
\author{Steven Novick <steven.j.novick@gsk.com>}
\keyword{IO}
