#' @export
SASiformat <- function(x, default)
  UseMethod("SASiformat")


#' @export
SASiformat.default <- function(x, default=NULL)
{
  lab <- attr(x,"SASiformat")
  if(is.null(lab))
    default
  else
  lab
}


#' @export
SASiformat.data.frame <- function(x, default=NULL)
{
  sapply( x, SASiformat)
}


#' @export
"SASiformat<-" <- function(x, value)
  UseMethod("SASiformat<-")

#' @export
"SASiformat<-.default" <- function(x, value)
{
  attr(x,'SASiformat') <- value
  x
}


#' @export
"SASiformat<-.data.frame" <- function(x, value)
{
  if( ncol(x) != length(value) )
    stop("vector of iformats must match number of data frame columns")

  for(i in 1:ncol(x))
    attr(x[[i]],'SASiformat') <- value[i]
  x
}
