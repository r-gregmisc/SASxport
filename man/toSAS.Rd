\name{toSAS.default}
\alias{toSAS}
\alias{toSAS.numeric}
\alias{toSAS.logical}
\alias{toSAS.character}
\alias{toSAS.factor}
\alias{toSAS.POSIXt}
\alias{toSAS.Date}
\alias{toSAS.default}
\title{Convert R Data Object for Storage in a SAS XPORT File}
\description{
  The \code{toSAS} methods control how R objects and data types are
  represented when stored into a SAS xport format file using
  \code{write.xport}.  
}
\usage{
toSAS(x, format, format.info=NULL)
\method{toSAS}{default}(x, format=SASformat(x), format.info=NULL)
\method{toSAS}{numeric}(x, format=SASformat(x), format.info=NULL)
\method{toSAS}{logical}(x, format=SASformat(x), format.info=NULL)
\method{toSAS}{character}(x, format=SASformat(x), format.info=NULL)
\method{toSAS}{factor}(x, format=SASformat(x), format.info=NULL)
\method{toSAS}{POSIXt}( x, format="DATETIME16.", format.info=NULL)
\method{toSAS}{Date}(x, format="DATE9.", format.info=NULL)
}
\arguments{
  \item{x}{ Object to be converted }
  \item{format}{SAS format name}
  \item{format.info}{Table of SAS format information}
}
\details{
  To add support for a new object type, create an appropriate
  \code{toSAS} method.  This method must convert the object data to
  either an object of type "numeric" (double-precision floating point)
  or type "character", the only basic types permitted by the xport
  format, and should add an attribute named "SASformat" to the object
  providing an appropriate SAS format string or "" (indicating the
  default SAS format).

  
  
}
\value{
  A vector of type "character" or of type "numeric", with an attribute
  named "label" containing the SAS format specification.
}
\author{ Gregory R. Warnes \email{greg@warnes.net} }
\seealso{
  \code{\link{write.xport}},
  \code{\link{read.xport}},
  \code{\link{lookup.xport}}
}
\examples{

####
## See how an R date/time object will be stored in a SAS xport file:
####

# Date and time
dateTimeObj <- ISOdate(2007,08,01,10,14,37)
class(dateTimeObj)
dateTimeObj

sasDateTimeObj <- toSAS(dateTimeObj)
sasDateTimeObj

# Now just the date portion
dateObj <- as.Date(dateTimeObj)
dateObj

sasDateObj <- toSAS(dateObj)
sasDateObj

####
## Create a new R object class based on factor to hold color names
####
colorFactor <- function(x) # constructor
  {
    retval <- factor(x, levels=c("Red","Green","Blue") )
    class(retval) <- c("colorFactor","factor")
    retval
  }

## create one and look at it
cf <- colorFactor( c("Red","Red","Blue",NA) )
cf

## See how it will be represented in a SAS xport file
toSAS(cf)

## Create a new conversion function to store as a RGB hex value
toSAS.colorFactor <- function(x, format="")
{
   retval <- ifelse(x=="Red", "#FF0000",
                    ifelse(x=="Green", "#00FF00", "#0000FF") )
   attr(retval, "SASformat") <- format
   retval
}

## see it in action
toSAS(cf)

}
\keyword{manip}
\keyword{IO}
