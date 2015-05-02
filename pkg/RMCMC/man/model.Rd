\name{model}
\alias{model}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ ~~function to do ... ~~ }
\description{
  ~~ A concise (1-5 lines) description of what the function does. ~~
}
\usage{
model(...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
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
function(...)
  {
    retval <- mycall <- match.call(expand.dots=TRUE)
    if(length(retval)==2 && retval[[1]]=="model")
      {
        # if we were passed a model, return it unchanged
        retval <- (...)  
      }
    else
      {
        # convert character strings and explicit expressions
        modes <- sapply(retval,mode)
        exprs <- sapply(retval, is.expression)

        calls <- sapply(retval, function(X) try(X[[1]], silent=T))

        convert <- which( (modes %in% c("character")) | calls=="expression" |
                         exprs)
        
        for(i in convert)
          {
            new <- eval(parse(text=paste("quote(",
                                gsub("expression\\((.*)\\)","\\1",
                                     sub("=", "<-",retval[i])),
                                ")")))
            retval[[i]] <- new
          }

        # do the same for objecs of class expressions
        
        
        # convert expressions of the form
        #    LHS=RHS
        # to
        #    LHS <- RHS
        # because R eats the LHS in the first form
        if(length(names(retval))>0)
          for( i in 1:length(names(retval)) )
            {
              LHS <- names(retval)[i]
              RHS <- retval[[i]]
              if(is.character(RHS)) RHS <- parse(text=RHS)
              if(LHS>"" && LHS != "data")
                retval[[i]] <- bquote( .(as.symbol(LHS)) <- .(RHS) )
            }
        names(retval) <- rep("",length(retval))

        which <- which(names(mycall)=="data")
        if(length(which)>0)
          {
            retval[[which]] <- eval(retval[[which]])
            names(retval)[which] <- "data"
          }

      }

    class(retval) <- "model"
    
    retval
  }
}
\keyword{ ~kwd1 }% at least one, from doc/KEYWORDS
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
