\name{trim}
\alias{trim}
\title{Remove leading and trailing spaces from character strings}
\description{
 Remove leading and trailing spaces from character strings and other
 related objects.
}
\usage{
trim(s, recode.factor=TRUE, \dots)
}
\arguments{
  \item{s}{object to be processed}
  \item{recode.factor}{should levels of a factor be recoded, see below}
  \item{\dots}{arguments passed to other methods, currently only to
    \code{\link{reorder.factor}} for factors}
}

\details{

\code{trim} is a generic function, where default method does nothing,
while method for character \code{s} trims its elements and method for
factor \code{s} trims \code{\link{levels}}. There are also methods for
\code{list} and \code{data.frame}.

Trimming character strings can change the sort order in some locales.
For factors, this can affect the coding of levels. By default, factor
levels are recoded to match the trimmed sort order, but this can be
disabled by setting \code{recode.factor=FALSE}. Recoding is done with
\code{\link{reorder.factor}}.

}
\value{
  \code{s} with all leading and trailing spaces removed in its elements.
}
\author{Gregory R. Warnes \email{greg@warnes.net}  with
  contributions by Gregor Gorjanc}
\seealso{ \code{\link[base]{sub}}, \code{\link[base]{gsub}} as well as
  argument \code{strip.white} in \code{\link{read.table}} and
  \code{\link{reorder.factor}}
}
\examples{
s <- "    this is an example string    "
trim(s)

f <- factor(c(s, s, " A", " B ", "  C ", "D "))
levels(f)

trim(f)
levels(trim(f))

trim(f, recode.factor=FALSE)
levels(trim(f, recode.factor=FALSE))

l <- list(s=rep(s, times=6), f=f, i=1:6)
trim(l)

df <- as.data.frame(l)
trim(df)
}
\keyword{manip}
\keyword{character}
