\name{getExcelWorksheet}
\alias{getExcelWorksheet}
\title{Read data from MS-Excel}
\description{Import one worksheets from a MS-Excel file}
\usage{getExcelWorksheet(file.name, sheet=1, rows=NULL, cols=NULL)}
\arguments{
  \item{file.name}{ String with full path and Excel file name. }
  \item{sheet}{ Vector of either numeric or character values that
    refer to the sheet number of sheet name in the Excel file. }
  \item{rows}{ Optionally denote the rows to import from each worksheet. }
  \item{cols}{ Optionally denote the columns to import from each worksheet. }
}
%\details{
%}
\value{
  Returns a list of data.frames.  Names of the returned list are the
  Excel sheet names.
}
\examples{

  # Use example MS-Excel File included with the package
  file.name <- file.path(.path.package("MSOfficeUtil"), "Examples",
                         "Grades.xls")
  # ~= C:\Program Files\R\rwNNNN\library\MSOfficeUtil\Examples\Grades.xls

  ## Import the data from the second worksheet in C:/Myfile.xls
  getExcelWorksheet(file.name, sheet=2)

  ## Import the data from the first and fourth worksheets.    
  getExcelWorksheet(file.name, sheet=c(1, 4))

  ## Import the data from the sheets named "Sheet1" and "Sheet3"
  getExcelWorksheet(file.name, sheet=c("Sheet1", "Sheet3"))

  ## Import the data in rows 1-3 and columns 1-2 from the second worksheet.
  getExcelWorksheet(file.name, sheet=2, rows=1:3, cols=1:2) 

}
\author{Steven Novick <steven.j.novick@gsk.com>}
\keyword{IO}
