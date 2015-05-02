\name{getExcelSheetNames}
\alias{getExcelSheetNames}
\title{Get MS-Excel sheet names}
\description{Get the names of the worksheets in a MS-Excel file.}
\usage{getExcelSheetNames(file.name)}
\arguments{
    \item{file.name}{ String with full path and Excel file name. }
}
%\details{
%}
\value{
  Returns a String vector.
}
\examples{

  # Use example MS-Excel File included with the package
  file.name <- file.path(.path.package("MSOfficeUtil"), "Examples",
                         "Grades.xls")
  # ~= C:\Program Files\R\rwNNNN\library\MSOfficeUtil\Examples\Grades.xls

  getExcelSheetNames(file.name)
}
\author{Steven Novick <steven.j.novick@gsk.com>}
\keyword{IO}

