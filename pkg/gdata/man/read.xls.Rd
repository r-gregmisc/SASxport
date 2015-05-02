\name{read.xls}
\alias{read.xls}
\alias{xls2csv}
\alias{xls2tab}
\alias{xls2tsv}
\alias{xls2sep}
\title{Read Excel files}
\description{Read a Microsoft Excel file into a data frame}
\usage{
read.xls(xls, sheet=1, verbose=FALSE, pattern, na.strings=c("NA","#DIV/0!"),
         ..., method=c("csv","tsv","tab"), perl="perl")
xls2csv(xls, sheet=1, verbose=FALSE, blank.lines.skip=TRUE, ..., perl="perl")
xls2tab(xls, sheet=1, verbose=FALSE, blank.lines.skip=TRUE, ..., perl="perl")
xls2tsv(xls, sheet=1, verbose=FALSE, blank.lines.skip=TRUE, ..., perl="perl")
xls2sep(xls, sheet=1, verbose=FALSE, blank.lines.skip=TRUE, ...,
        method=c("csv","tsv","tab"), perl="perl")
}
\arguments{
  \item{xls}{path to the Microsoft Excel file.  Supports "http://",
    "https://", and "ftp://" URLS.}
  \item{sheet}{name or number of the worksheet to read}
  \item{verbose}{logical flag indicating whether details should be
    printed as the file is processed.}
  \item{pattern}{if specified, them skip all lines before the first 
    containing this string}
  \item{perl}{name of the perl executable to be called.}
  \item{method}{intermediate file format, "csv" for comma-separated and
    "tab" for tab-separated}
  \item{na.strings}{a character vector of strings which are to be interpreted
          as 'NA' values. See \code{\link[utils]{read.table}} for
	  details.}
  \item{blank.lines.skip}{logical flag indicating whether blank lines in
    the orginal file should be ignored.}
  \item{...}{additional arguments to read.table. The defaults for
    read.csv() are used.}
}
\value{
  \code{"read.xls"} returns a data frame.

  \code{"xls2sep"} returns a temporary file in the specified format.  
  \code{"xls2csv"} and \code{"xls2tab"} are simply wrappers for
  \code{"xls2sep"} specifying method as "csv" or "tab", respectively.
}
\details{
  This function works translating the named Microsoft Excel file into a
  temporary .csv or .tab file, using the xls2csv or xls2tab
  Perl script installed as part of this (gdata) package.

  Caution: In the conversion to csv, strings will be quoted. This can be
    problem if you are trying to use the \code{comment.char} option of
  \code{read.table} since the first character of all lines (including
  comment lines) will be "\"" after conversion.

  If you have quotes in your data which confuse the process you may wish to use 
  \code{read.xls(..., quote = '')}.  This will cause the quotes to be regarded
  as data and you will have to then handle the quotes yourself after reading 
  the file in.

  Caution: If you call \code{"xls2csv"} directly, is your responsibility 
  to close and delete the file after using it.
}
\references{http://www.analytics.washington.edu/statcomp/downloads/xls2csv}
\note{ Either a working version of Perl must be present in the executable
  search path, or the exact path of the perl executable must be provided
  via the \code{perl} argument.  See the examples below for an illustration.}
\seealso{ \code{\link[utils]{read.csv}} }
\examples{

   # iris.xls is included in the gregmisc package for use as an example
   xlsfile <- file.path(path.package('gdata'),'xls','iris.xls')
   xlsfile

   iris <- read.xls(xlsfile) # defaults to csv format
   iris <- read.xls(xlsfile,method="csv") # specify csv format
   iris <- read.xls(xlsfile,method="tab") # specify tab format

   head(iris)  # look at the top few rows

   \dontshow{
   iris.1 <- read.xls(xlsfile) # defaults to csv format
   iris.2 <- read.xls(xlsfile,method="csv") # specify csv format
   iris.3 <- read.xls(xlsfile,method="tab") # specify tab format

   stopifnot(all.equal(iris.1, iris.2))
   stopifnot(all.equal(iris.1, iris.3))
   }


  \dontrun{
   ## Example specifying exact Perl path for default MS-Windows install of
   ## ActiveState perl
   iris <- read.xls(xlsfile, perl="C:/perl/bin/perl.exe")
   }

   \dontrun{
   ## Example specifying exact Perl path for Unix systems
   iris <- read.xls(xlsfile, perl="/usr/bin/perl")

   ## finding perl 
   ## (read.xls automatically calls findPerl so this is rarely needed)
   perl <- gdata:::findPerl("perl")
   iris <- read.xls(xlsfile, perl=perl)
   }

   \dontrun{
   ## read xls file from net
   nba.url <- "http://mgtclass.mgt.unm.edu/Bose/Excel/Tutorial.05/Cases/NBA.xls"
   nba <- read.xls(nba.url)
   }

   \dontrun{
   ## read xls file ignoring all lines prior to first containing State
   crime.url <- "http://www.jrsainfo.org/jabg/state_data2/Tribal_Data00.xls"
   crime <- read.xls(crime.url, pattern = "State")

   ## use of xls2csv - open con, print two lines, close con
   con <- xls2csv(crime.url)
   print(readLines(con, 2)) 
   file.remove(summary(con)$description)
   }

   ## Examples demonstrating selection of specific 'sheets'
   ## from the example XLS file 'ExampleExcelFile.xls'
   exampleFile <- file.path(path.package('gdata'),'xls',
                            'ExampleExcelFile.xls')
   exampleFile2007 <- file.path(path.package('gdata'),'xls',
                            'ExampleExcelFile.xlsx')

   ## see the number and names of sheets:
   sheetCount(exampleFile)
   if( 'XLSX' \%in\% xlsFormats() )  ## if XLSX is supported..
     sheetCount(exampleFile2007)


   ## show names of shets in the file
   sheetNames(exampleFile)
   if( 'XLSX' \%in\% xlsFormats() )  ## if XLSX is supported..
   sheetNames(exampleFile2007)

   data <- read.xls(exampleFile)          ## default is first worksheet
   data <- read.xls(exampleFile, sheet=2) ## second worksheet by number
   data <- read.xls(exampleFile, sheet="Sheet Second",v=TRUE) ## and by name

   ## load the third worksheet, skipping the first two non-data lines...
   if( 'XLSX' \%in\% xlsFormats() )  ## if XLSX is supported..
     data <- read.xls(exampleFile2007, sheet="Sheet with initial text", skip=2)

   ## load a file containing data and column names using latin-1
   ## characters
   latinFile <- file.path(path.package('gdata'),'xls','latin-1.xls')
   latin1 <- read.xls(latinFile, fileEncoding="latin1")
   colnames(latin1)


}
\author{
  Gregory R. Warnes \email{greg@warnes.net},
  Jim Rogers \email{james.a.rogers@pfizer.com}, and
  Gabor Grothendiek \email{ggrothendieck@gmail.com}.
}
\keyword{file}
