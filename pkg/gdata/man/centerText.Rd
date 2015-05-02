\name{centerText}
\alias{centerText}
\title{
Center Text Strings 
}
\description{
Function to center text strings for display on the text console
by prepending the necessary number of spaces to each element.
}
\usage{
centerText(x, width = getOption("width"))
}
\arguments{
  \item{x}{Character vector containing text strings to be centered.}
  \item{width}{Desired display width. Defaults to the R display width
    given by \code{getOption("width")}. }
}
\details{
    Each element will be centered individually by prepending the
    necessary number of spaces to center the text in the specified
    display width assuming a fixed width font.
}
\value{
Vector of character strings.
}
\author{
Gregory R. Warnes \email{greg@warnes.net}
}
\seealso{
  \code{\link[base]{strwrap}}
}
\examples{
cat(centerText("One Line Test"), "\n\n")

mText <-c("This", "is an example",
          " of a multiline text    ",
          "with ",
          "          leading",
          " and trailing         ",
          "spaces.")
cat("\n", centerText(mText), "\n", sep="\n")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{manip}
\keyword{character}

