#' @export
SASlength <- function(x, default) {
  UseMethod("SASlength")
}

#' @export
SASlength.default <- function(x, default = NULL) {
  lab <- attr(x,"SASlength")
  if(is.null(lab))
    default
  else
    lab
}

#' @export
SASlength.data.frame <- function(x, default = NULL) {
  sapply(x, SASlength)
}

#' @export
`SASlength<-` <- function(x, value){
  UseMethod("SASlength<-")
}

#' @export
`SASlength<-.default` <- function(x, value) {
  attr(x,'SASlength') <- value
  x
}

#' @export
`SASlength<-.data.frame` <- function(x, value)
{
  if( ncol(x) != length(value) )
    stop("vector of formats must match number of data frame columns")

  for(i in 1:ncol(x))
    attr(x[[i]],'SASlength') <- value[i]
  x
}
