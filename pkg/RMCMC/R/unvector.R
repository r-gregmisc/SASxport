# $Id$

unvector <- function(x, template=x)
  {
    # split on unique name bases after stripping digits from end
    namelist <- names(template)
    namelist <- gsub('[0-9]*$','',namelist,extended=TRUE)
    newlist <- split(x,namelist)
    newlist
  }
