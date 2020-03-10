\name{write.xport}
\alias{write.xport}
\title{Write Data to a SAS XPORT File}
\description{
  This function writes one or more data frames into a SAS XPORT format
  library file.
}
\usage{
write.xport(...,
            list=base::list(),
            file = stop("'file' must be specified"),
            verbose=FALSE,
            sasVer="7.00",
            osType,
            cDate=Sys.time(),
            formats=NULL,
            autogen.formats=TRUE
 )
}
\arguments{
  \item{\dots}{One or more data frames to be stored}
  \item{list}{A list containing data frames to be stored.}
  \item{file}{File name or connection object. Use "" to view the raw data}
  \item{verbose}{Logical flag controlling whether status is reported
    during processing}
  \item{sasVer}{SAS version string}
  \item{osType}{Operating system, defaults to "R X.Y.Z" for
    appropriate values of X, Y, and Z}
  \item{cDate}{Date object specifying dataset creation date}
  \item{formats}{Optional data frame containing SAS format information.}
  \item{autogen.formats}{Logical indicating whether SAS formats should be
    auto-generated for factor variables.}
}
\details{
  The function creates a SAS XPORT data file (see reference) from one or
  more data frames.  This file format imposes a number of constraints:
  \itemize{
    \item Data set and variable names are truncated to 8 characters and
      converted to upper case.  All characters outside of the set A-Z,
      0-9, and '\_' are converted to '\_'.
    \item Character variables are stored as characters.
    \item If \code{autogen.formats=TRUE} (the default), factor variables
      are stored as numeric with an appropriate SAS format
      specification. If \code{autogen.formats=FALSE}, factor variables
      are stored as characters.
    \item All numeric variables are stored as double-precision floating
      point values utilizing the IBM mainframe double precision floating
      point format (see the reference).
    \item Date and time variables are either converted to number of days since
      1960-01-01 (date only), or number of seconds since
      1960-01-01:00:00:00 GMT (date-time variables).
    \item Missing values are converted to the standard SAS missing value
      '.'
  }

  The SAS XPORT format allows each dataset to have a label and a type
  (set via the \code{\link{label}} and \code{\link{SAStype}} functions).
  In addition, each variable may have a corresponding label, display
  format, and input format.  To set these values, add the attribute
  'label', 'SASformat', or 'SASiformat' to individual data frame.  These
  attributes may be set using the \code{\link{label}},
  \code{\link{SASformat}}, and \code{\link{SASiformat}} functions. (See
  examples provided below.)

  The actual translation of R objects to objects appropriate for SAS is
  handled by the \code{\link{toSAS}} generic and associated methods,
  which can be (re)defined by the user to provide fine-grained control.
}
\value{
  No return value
}
\references{
  SAS Technical Support document TS-140: ``The Record Layout of a
  Data Set in SAS Transport (XPORT) Format'' available at
  \url{https://support.sas.com/techsup/technote/ts140.pdf}
}
\author{Gregory R. Warnes \email{greg@warnes.net}}
\note{
   This package was created with partial funding by Metrum Institute
   \url{http://metruminstitute.org}.
}
\seealso{
  \code{\link{toSAS}},
  \code{\link{lookup.xport}},
  \code{\link{read.xport}},
  \code{\link{label}},
  \code{\link{SAStype}},
  \code{\link{SASformat}},
  and \code{\link{SASiformat}}
}
\examples{

#####
## R version of the example given in TS-140
#####

## manually create a data set
abc <- data.frame(
  x=c(1, 2, NA, NA),
  y=c('a', 'B', NA, '*'),
  stringsAsFactors=TRUE
  )

## look at it
abc

## add a format specifier (not used by R)
SASformat(abc$x) <- 'date7.'

## add a variable label (not used by R)
label(abc$y) <- 'character variable'

## add a dataset label and type
label(abc) <- 'Simple example'
SAStype(abc) <- 'MYTYPE'

## verify the additions
str(abc)

# create a SAS XPORT file
tmp <- tempfile(fileext = ".dat")
write.xport( abc, file = tmp )

# list the contents of the file
lookup.xport(tmp)

## reload the data
xxx.abc <- read.xport(tmp)

## and look at it
xxx.abc

## Check the label and type
label(xxx.abc)
SAStype(xxx.abc)

## Note that the variable names and SAS dataset type have been converted
## to uppercase

}
\keyword{file}
