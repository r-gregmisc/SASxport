insert.arg <- function(expr, ...)
  {
    CALL <- expr[[1]]
    ARGS <- expr
    ARGS[[1]] <- list(...)[[1]]
    newCALL <- as.call(c( CALL, as.list(ARGS) ))
    newCALL
  }
