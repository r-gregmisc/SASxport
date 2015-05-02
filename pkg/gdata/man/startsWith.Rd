\name{startsWith}
\alias{startsWith}
\title{
  Determine if a character string "starts with" with the specified characters.
}
\description{
  Determine if a character string "starts with" with the specified characters.
}
\usage{
startsWith(str, pattern, trim=FALSE, ignore.case=FALSE)
}
\arguments{
  \item{str}{character vector to test}
  \item{pattern}{characters to check for}
  \item{trim}{Logical flag indicating whether leading whitespace should
    be removed from \code{str} before testing for a match.}
  \item{ignore.case}{Logical flag indicating whether case should be
    ignored when testing for a match.}
}
\details{
  This function returns TRUE for each element of the vector \code{str}
  where \code{pattern} occurs at the beginning of the string.  If
  \code{trim} is TRUE, leading whitespace is removed from the elements
  of \code{str} before the test is performed. If \code{ignore.case} is
  TRUE, character case is ignored.
}
\value{
  Boolean vector of the same length as \code{str}.
}
\author{
  Gregory R. Warnes \email{greg@warnes.net}
}
\seealso{
  \code{\link[base]{substr}},  \code{\link{trim}} 
}
\examples{
## simplest example:
startsWith( 'Testing', 'Test')

## vector examples
s <- c('Testing', ' Testing', 'testing', 'Texting')
names(s) <- s

startsWith(s, 'Test')                   # ' Testing', 'testing', and 'Texting' do not match
startsWith(s, 'Test', trim=TRUE)        # Now ' Testing' matches
startsWith(s, 'Test', ignore.case=TRUE) # Now 'testing' matches
}
\keyword{character}
