# %Id$

signame <- function(val)
  {
    retval <- .C("Rfork_signame",
                 name=character(1),
                 val=as.integer(val),
                 desc=character(1),
                 PACKAGE="fork")
    unlist(retval)
  }

sigval <- function(name)
  {
    name <- toupper(name)
    if( length(grep("SIG",name))!=1 )
       name <- paste("SIG", name, sep="")
    retval <- .C("Rfork_siginfo",
                 name=name,
                 val=integer(1),
                 desc=character(1),
                 PACKAGE="fork")
    #retval <- unlist(retval)
    retval
  }

siglist <- function()
  {
    retval <- .Call("Rfork_siglist",
                    PACKAGE="fork")
    retval <- as.data.frame(retval)
    names(retval) <- c("name","val","desc")
    retval
  }

#siginfo <- function(val, name)
#  {
#    if(missing(val) && missing(name))
#      return(siglist())
#    else if (missing(val))
#      return(sigval(name))
#    else
#      return(signame(val))
#  }
