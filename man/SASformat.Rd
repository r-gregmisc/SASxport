\name{SASformat}

\alias{SASformat}
\alias{SASformat.default}
\alias{SASformat<-}
\alias{SASformat<-.default}

\alias{SASiformat}
\alias{SASiformat.default}
\alias{SASiformat<-}
\alias{SASiformat<-.default}

\alias{SAStype}
\alias{SAStype.default}
\alias{SAStype<-}
\alias{SAStype<-.default}

\title{
Set or Retreive the 'label', 'SASformat', 'SASiformat', or 'SAStype'
attribute of a vector or (components of) a data frame
}
\description{
  Sets or retrieves the %\code{"label"},%
  \code{"SASformat"},
  \code{"SASiformat"}, or \code{SAStype} attribute of an object.

  More comprehensive support for object labels, and SASformat, are
  available in Frank Harrell's \code{Hmisc} package.

  Note that \code{SAStype} enforces the SAS 8-character naming convention.
}
\usage{
SASformat(x, default)
SASformat(x) <- value

SASiformat(x, default)
SASiformat(x) <- value

SAStype(x, default)
SAStype(x) <- value
}
\arguments{
\item{x}{any object}
\item{value}{new value for the  \code{"label"}, \code{"SASformat"},
  \code{"SASiformat"}, or \code{SAStype}  attribute of an object.}
\item{default}{value to return when no appropriate attribute is
  found.  The usual return value is NULL.}
}
\value{
  the contents of the \code{"label"}, \code{"SASformat"},
  \code{"SASiformat"}, \code{"SAStype"} attribute of x, if any;
  otherwise, the value provided by \code{default}.
}
\author{
  Gregory R. Warnes \email{greg@warnes.net} based on code from the
  \code{Hmisc} library by Frank E. Harrell, Jr.  ]
}
%\seealso{
%}
\examples{

## Examples for vectors

fail.time <- c(10,20)

# set attributes
SASformat(fail.time) <- 'Numeric2'
SASiformat(fail.time) <- 'Numeric2'

# display individual attributes
SASformat(fail.time)
SASiformat(fail.time)

# display all attributes
attributes(fail.time)

## SAStype only applies to data frames
df <- data.frame( fail.time, day=c("Mon","Tue") )
SAStype(df) <- "USER"

SAStype(df)

## Example showing specification of default return value
a <- 70
label(a, default="no label")
}
\keyword{utilities}
\keyword{interface}

