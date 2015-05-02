# $Id$

.Last.lib <- function(libpath)
  {
    dyn.unload(file.path(libpath, "libs",
                         paste("Rlsf", .Platform$"dynlib.ext", sep="")))
  }
