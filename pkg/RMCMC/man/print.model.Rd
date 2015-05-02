\name{print.model}
\alias{print.model}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ ~~function to do ... ~~ }
\description{
  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
print.model(x, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ ~~Describe \code{x} here~~ }
  \item{\dots}{ ~~Describe \code{\dots} here~~ }
}
\details{
  ~~ If necessary, more details than the __description__  above ~~
}
\value{
  ~Describe the value returned
  If it is a LIST, use
  \item{comp1 }{Description of 'comp1'}
  \item{comp2 }{Description of 'comp2'}
  ...
}
\references{ ~put references to the literature/web site here ~ }
\author{ ~~who you are~~ }
\note{ ~~further notes~~ }

 ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function(x,...)
  {
    cat("\n")
    cat("Bayesian Model Specification\n")
    cat("\n")
    cat("Formulae:\n")
    dptr <- which(names(x)!="data")
    formulae <- x
    if(length(dptr)>0)
      {
        data <- x[[dptr]] 
        formula[dptr] <- NULL
      }
    else
      data <- NULL
    for(i in 2:length(formulae))
      {
          cat(i-1,': ')
          print(formulae[[i]])
        }
    if(length(data)>0)
      {
        cat("\n")
        cat("Data:\n")
        for(i in 2:length(data))
          {
            cat(i-1,': ',names(data)[i],"=",sep='')
            str(data[[i]])
          }
      }
    cat("\n")
  }
}
\keyword{ ~kwd1 }% at least one, from doc/KEYWORDS
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
