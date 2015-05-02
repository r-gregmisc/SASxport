# $Id$

combine  <-  function(..., names=NULL)
  {
    tmp  <-  list(...)
    if(is.null(names)) names  <- names(tmp)
    if(is.null(names)) names  <- sapply( as.list(match.call()), deparse)[-1]

    if( any(
            sapply(tmp, is.matrix)
            |
            sapply(tmp, is.data.frame) ) )
      {
        len  <-  sapply(tmp, function(x) c(dim(x),1)[1] )
        len[is.null(len)]  <-  1
        data <-  rbind( ... )
      }
    else
      {
        len  <- sapply(tmp,length)
        data  <-  unlist(tmp)

      }

    namelist  <- factor(rep(names, len), levels=names)

    return( data.frame( data, source=namelist) )
  }
