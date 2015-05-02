# $Id$

insert.list <- function(ll, at, ...)
{
  if(at<=1)
    unlist( list(list(...), ll), recursive=FALSE )
  else if (at > length(ll))
    unlist( list(ll, list(...)), recursive=FALSE )
  else
    unlist(
           list(ll[1:(at-1)],
                list(...),
                ll[at:length(ll)]),
           recursive=FALSE)
}  

insert.body <- function( FUN, MARKER, VALUE)
  {
    retval <- body(FUN)
    index <- grep(MARKER, as.character(retval))
    for(i in length(retval):index)
      retval[[i+1]] <- retval[[i]]
    retval[[index]] <- VALUE
    retval
  }

insert.function <- function( FUN, MARKER, VALUE)
  {
    body(FUN) <- insert.body(FUN, MARKER, VALUE)
    FUN
  }

remove.marker <- function( FUN, MARKER )
  {
    for(M in MARKER)
      {
        where <- grep(M, as.character(body(FUN)))
        body(FUN)[[where]] <- NULL
      }
    FUN
  }
