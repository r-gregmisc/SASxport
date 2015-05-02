\name{makeSASNames}
\alias{makeSASNames}
\title{
  Create valid and unique SAS names from a character vector.
}
\description{
  Create valid and unique SAS names from a character vector.
}
\usage{
makeSASNames(names, nchar = 8, maxPasses = 10, quiet=FALSE)
}
\arguments{
  \item{names}{character vector of candidate names}
  \item{nchar}{maximum number of characters}
  \item{maxPasses}{maximum number of interations to resolve
    truncation-related name duplication.}
  \item{quiet}{Logical indicating whether to generate warning messages
    when names are truncated or made unique.}
}
\details{
  This function creates valid SAS names from a list of R object or
  column names, properly handling case conversion (all converted to
  upper-case), length restructions (8 characters), and making duplicate
  names unique. This is not as obvious as it appears, since the process
  of shortening names can cause duplicates, and adding digits to the end
  of names to make them unique can make them too long, so a few
  iterations may be required to ensure valid and unique names.
}
\value{
  character vector of unique names valid in SAS.
}
\author{
  Gregory R. Warnes \email{greg@warnes.net}
}
\seealso{
  \code{\link[base]{make.names}}
}
\examples{
  ## Simple example: no duplicates or more than 8 characters
  makeSASNames( c("height","weight","age","gender"))

  ## Resolve duplicates
  makeSASNames( c("a","a","b","b","b","c") )

  ## Truncate long names
  makeSASNames( c("alphabetic", "numeric", "alphanumeric", "whitespace"))

  ## Truncate and make unique
  makeSASNames( rep( c("aaaaaaaaaaa","bbbbbbbbbb"), each=3) )

  ## Now do it quietly!
  makeSASNames( rep( c("aaaaaaaaaaa","bbbbbbbbbb"), each=3), quiet=TRUE)
}
\keyword{manip}

