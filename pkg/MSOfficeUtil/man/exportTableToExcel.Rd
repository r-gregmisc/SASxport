\name{exportTableToExcel}
\alias{exportTableToExcel}
\title{Export data to MS-Excel}
\description{Export a data frame to MS-Excel.}
\usage{exportTableToExcel(df, file.name, sheet=1, range=NULL, overwrite=TRUE)}
\arguments{
  \item{df}{data.frame to be exported. }
  \item{file.name}{String with full path and Excel file name. }
  \item{sheet}{Single number or String to denote the Excel sheet.  If
    the sheet does not exist, a new sheet is created. }
  \item{range}{Optionally, denote the Excel range to target (ADVANCED!) }
  \item{overwrite}{Boolean to denote whether or not to overwrite the
    Excel file (should it exist).  If FALSE and the Excel file exists, the
    data will be exported below any existing data in the given Excel
    worksheet.}
}
%\details{
%}
%\value{
%}
\examples{
  ## Export data.frame (df) to MyDatafile.xls.  Overwrite file if it exists.
  exportTableToExcel(df, "C:/MyDatafile.xls")

  ## Will export df below any existing data in MyDatafile.xls.
  exportTableToExcel(df, "C:/MyDatafile.xls", overwrite=FALSE)

  ## Will export df to the second worksheet in MyDatafile.xls.
  exportTableToExcel(df, "C:/MyDatafile.xls", sheet=2)
}
\author{Steven Novick <steven.j.novick@gsk.com>}
\keyword{IO}
