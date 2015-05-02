SAStype <- function(x, default)
  UseMethod("SAStype")

SAStype.default <- function(x, default=NULL)
{
  lab <- attr(x,"SAStype")
  if(is.null(lab))
    default
  else
  lab
}

"SAStype<-" <- function(x, value)
  UseMethod("SAStype<-")

"SAStype<-.default" <- function(x, value)
{
  attr(x,'SAStype') <- makeSASNames(value)
  x
}
