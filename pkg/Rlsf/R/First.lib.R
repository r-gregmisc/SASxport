# $Id$

.First.lib <- function(libname, pkgname)
{
  library.dynam("Rlsf", pkgname, libname)
  if (!TRUE)
    stop("Failed to load the Rlsf dynamic library.")
  if (!is.loaded("lsf_initialize"))
    stop("Rlsf has probably been detached. Please quit R.")
  if (.Call("lsf_initialize", PACKAGE = "Rlsf"))
    stop("LSF library cannot be initialized.")
  
#  if (!library(Rmpi,logical.return = TRUE))
#    {
#      stop("Rmpi library cannot be loaded")
#    }
#  if (!library(snow,logical.return = TRUE))
#    {
#      stop("snow library cannot be loaded")
#    }
#
#  options(error=quote(assign(".mpi.err", FALSE, env = .GlobalEnv)))
#
#  if (!interactive())
#    options(echo=FALSE)
#
#  if (mpi.comm.size(0) > 1)
#    invisible(mpi.comm.dup(0,1))
#
#  if (mpi.comm.rank(0) >0){
#    sys.load.image(".RData",TRUE)
#    .comm <- 1
#    while (1) {
#      try(eval(mpi.bcast.cmd(rank=0,comm=.comm),envir=sys.parent()))
#    }
#                                        #    mpi.barrier(.comm)
#    mpi.comm.free(.comm)
#    mpi.quit()
#  }
#
#  if (mpi.comm.rank(0) == 0) {
#    
#    mylib <- dirname(.path.package("Rmpi"))
#    ver <- packageDescription("Rmpi", lib = mylib)["Version"]
#    vertxt <- paste("\n\tRmpi version:", ver, "\n")
#    introtxt <- paste("\tRmpi is an interface (wrapper) to MPI APIs\n",
#                      "\twith interactive R slave functionalities\n",
#                      "\tSee `library (help=Rmpi)' for details.\n", sep = "")
#    cat(paste(vertxt, introtxt))
#    cat("\n")
#
#    if(mpi.comm.size(0) > 1)
#      slave.hostinfo(1)
#    else {
#      if (!interactive())
#        mpi.hostinfo(0)
#    }
#  }
#
#  if (mpi.comm.size(0) > 1)
#    assign(".comm", 1, .GlobalEnv)
#  else
#    assign(".comm", 0, .GlobalEnv)	
}
