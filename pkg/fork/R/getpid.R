# $Id$

getpid <- function()
  {
    .C("Rfork_getpid",
       pid=integer(1),
       PACKAGE="fork"
       )$pid
  }

