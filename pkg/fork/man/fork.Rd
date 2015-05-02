% $Id$
\name{fork}
\alias{fork}
\title{Create a new R process using the Unix 'fork' system call}
\description{
  Create a new R process using the Unix 'fork' system call.
}
\usage{
fork(slave)
}
\arguments{
  \item{slave}{Function to be executed in the new R process. This can be
  \code{NULL}, see details.}
}
\details{
  This function provides a thin wrapper around the Unix "fork" system
  call, which will create a new process which is an exact copy of the
  current R process, including open files and sockets including STDIN
  and STDOUT.
  
  The \code{child} parameter should  normally contain a function
  to be executed in the newly created process.  This function will be
  called in the new process, and \code{exit()} will be called when it
  returns to terminate the process.

  If you wish to explicitly control what happens in the child process,
  you can pass \code{child=NULL}, in which case you are responsible for
  managing all the details.

  First, the child process must call \code{exit()} to terminate instead
  of \code{quit}.  This is necessary to ensure that temporary files
  or directories created by the parent process are not removed by the
  child.

  Second, the child process should not attempt to use STDIN to obtain
  commands since it shares all files open at the time of the fork with
  the parent.  This includes STDIN, consequently, any code following
  the fork will be be obtained *competitively* by both processes.  This
  usually means that neither process will get a consistent picture of
  the following commands, since which process gets each line will be
  simply a matter of which process asked first.

  The best way to avoid the second problem is to simply pass a function
  to \code{fork} using the \code{slave} parameter.  Another way to
  accomplish this is to ensure that all code that needs to be executed
  has already been fed to the interpreter before the fork call occurs.
  The simplest mechinism to achieve this is to wrap the code containing
  the fork in a code block using curly brackets (\code{\{ ... \}}).
  This can be a top-level code block, or can be withing a loop or
  function call.,
 
  To illustrate, this code is a familiar C idiom for forking will NOT be
  interpreted properly:

\preformatted{
  pid = fork(slave=NULL)
      
  if(pid==0) { 
      
    cat("Hi from the child process"); exit() 
      
  } else { 
      
    cat("Hi from the parent process"); 
      
  }
}

  On the other hand, wrapping this code with curly brackets ensures it
  IS intepreted properly:
    
\preformatted{
  {
    pid = fork(slave=NULL) 
    if(pid==0) { 
      cat("Hi from the child process\n"); exit() 
    } else {
      cat("Hi from the parent process\n");
    } 
  } 
}

.
}
\value{
   This function returns the process ID of the child
   process to the parent process.  If \code{slave} is \code{NULL} the
   function returns 0 to the  child  process.
}
\references{'fork' man page}
\author{ Gregory R. Warnes \email{greg@warnes.net}}
\seealso{\code{\link{getpid}}, \code{\link{exit}}, \code{\link{wait}},
         \code{\link{kill}}, \code{\link{killall}} }
\examples{

###
# Count from 1 to 10 in a separate process
###

# define the function to do the work
testfun <- function()
  {
    cat("Counting in process", getpid(), "\n")
    for(i in 1:10)
      {
        i <<- i+1  # assign into Global environment
        cat("i=",i,"\n")
      }
    cat("Done counting in process", getpid(), "\n")
  }

# run normally, the function will change our value of i
i <- 0
testfun()
i 

# Run in a separate process, our value of i remains unchanged
i <- 0
{
  pid <- fork(testfun)
  wait(pid) # wait until the child finishes, then display its exit status
}
 

###
# Use a socket to communicate between two processes.  Information
# typed on the console, which is read by the initial process, will be send
# to the child process for display. 
###
\dontrun{
send <- function()
  {
     pid <- getpid()
     con1 <- socketConnection(Sys.info()["nodename"], port = 6011)
     i <- 1
     while(TRUE)
       {
         cat("[",pid,"] ",i,": ",sep="")
         data <- readLines(stdin(), n=1)
         writeLines(data, con=con1)
         if( length(grep("quit", data))>0 )
            break;
         i <- i+1
       }
     close(con1)
  }

recieve <- function()
  {
     pid <- getpid()
     con2 <- socketConnection(port = 6011, block=TRUE, server=TRUE)
     i <- 1
     while(TRUE)
       {
          data <- readLines(con2, n=1)
          cat("[",pid,"] ",i,": ",sep="")
          writeLines(data, stdout())
          if( length(grep("quit", data))>0 )
              break;
          i <- i+1
       }
     close(con2)
  }

## Important: if we aren't going to explicitly wait() for the child
## process to exit, we need to set up a dummy signal handler to collect
## (and then throw away) the exit status so that child processes will not
## become zombies when they exit
handleSIGCLD()

# fork off the process
pid <- fork(recieve)

# start sending...
send()
}

## restore SIGCLD signal handling to the previous state
restoreSIGCLD()
}
\keyword{programming}

