print.model <- function(x,...)
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
