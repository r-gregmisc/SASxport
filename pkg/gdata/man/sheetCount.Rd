\name{sheetCount}
\Rdversion{1.1}
\alias{sheetCount}
\alias{sheetNames}
\title{
Count or list sheet names in Excel spreadsheet files.
}
\description{
Count or list sheet names in Excel spreadsheet files.
}
\usage{
sheetCount(xls, verbose = FALSE, perl = "perl")
sheetNames(xls, verbose = FALSE, perl = "perl")
}
\arguments{
  \item{xls}{File path to spreadsheet.  Supports "http://",
    "https://", and "ftp://" URLS.}
  \item{verbose}{If \code{TRUE}, show additional messages during
    processing.}
  \item{perl}{Path to perl interpreter.}
}
\value{
  \code{sheetCount} returns the number of sheets in the spreadsheet.
  \code{sheetNames} returns the names of sheets  in the spreadsheet.
}

\seealso{
	\code{\link{read.xls}}, \code{\link{xls2csv}}.
}
\examples{
   xlsfile <- system.file("xls", "iris.xls", package = "gdata")
   xlsfile

   sheetCount(xlsfile)


   exampleFile <- file.path(path.package('gdata'),'xls',
                            'ExampleExcelFile.xls')
   exampleFile2007 <- file.path(path.package('gdata'),'xls',
                            'ExampleExcelFile.xlsx')

   sheetCount(exampleFile)

   if( 'XLSX' \%in\% xlsFormats() )  # if XLSX is supported..
     sheetNames(exampleFile2007)


}
\keyword{ misc }
