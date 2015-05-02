SASiformat <- function(x, default)
  UseMethod("SASiformat")

SASiformat.default <- function(x, default=NULL)
{
  lab <- attr(x,"SASiformat")
  if(is.null(lab))
    default
  else
  lab
}

"SASiformat<-" <- function(x, value)
  UseMethod("SASiformat<-")

"SASiformat<-.default" <- function(x, value)
{
  attr(x,'SASiformat') <- value
  x
}
