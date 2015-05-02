as.model <- function(x,...)
  UseMethod("as.model")

as.model.model <- function(x,...)
  x

as.model.list <- function(x,...)
  {
    do.call("model",c(x,...))
  }
