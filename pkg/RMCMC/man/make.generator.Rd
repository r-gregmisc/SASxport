\name{make.generator}
\alias{make.generator}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ ~~function to do ... ~~ }
\description{
  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
make.generator(m, data)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{m}{ ~~Describe \code{m} here~~ }
  \item{data}{ ~~Describe \code{data} here~~ }
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
function(m, data)
{
  if(!is.call(m)) stop("The model 'm' is not a model object (see ?model)")
  
  newcode <- function(...)
    {
      parms <- list(...)
      if(length(parms)==1 && is.list(parms[[1]])) parms <- parms[[1]]
      attach(parms)
      retval <- list()
      # added code goes here
    }
  index <- 6

  if(missing(data))
    {
      data <- m$data
    }
  m$data <- NULL

  for( expr in as.list(m))
    {
      if(length(expr)==3)
        {
          CALL <- expr[[1]]
          LHS <- expr[[2]]
          RHS <- expr[[3]]
          if(CALL=="~" || CALL=="<-")
            {
              newCALL <- expr
              
              # make into an assignment
              newCALL[[1]] <- as.symbol("<-")

              # tack retval$ onto LHS
              newCALL[[2]] <- eval(parse(text=paste("quote(retval$",LHS,")")))

              # get proper random generator for the disn
              fun <- as.character(RHS[[1]])
              fun <- lookup.table[[fun]]$random
              if(is.null(fun))
                stop("Unable to find a random generator function for '", CALL,
                     "' in lookup.table")
              newRHS <- newCALL[[3]]
              newRHS[[1]] <- as.symbol(fun)
              newRHS <- insert.arg(newRHS, bquote(  length( .(LHS) )  ) )

              newCALL[[3]] <- newRHS

              # put into function
              body(newcode)[[index]] <- newCALL
              index <- index + 1
            }
        }
      else if (!is.null(expr) && nchar(as.character(expr)) > 0 )
        {
          cat("Skipping expression with length!=3: '",
              deparse(substitute(expr)), "'\n", sep='')
        }
      else
        {
          cat("Skipping empty line\n")
        }
    }
  body(newcode)[[index]] <- quote(detach(parms))
  index <- index+1

  body(newcode)[[index]] <- quote(return(retval))
  index <- index+1

  # Create an environment to hold the constant data

  newenv <- new.env()
  for(n in names(data))
    {
      cat("Added",n,"to the function environment.\n") 
      assign(n, data[[n]], env=newenv)
    }

  environment(newcode) <- newenv
  
  newcode
  }
}
\keyword{ ~kwd1 }% at least one, from doc/KEYWORDS
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
