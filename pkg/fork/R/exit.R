# $Id$

exit <- function(status=0)
  {
    .C("Rfork__exit",
       as.integer(status),
       PACKAGE="fork")
  }
