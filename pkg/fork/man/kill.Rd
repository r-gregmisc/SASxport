% $Id$
\name{kill}
\alias{kill}
\alias{killall}
\title{Send a signal to one or more processes.}
\description{ 
  \code{kill} sends a signal to a process.  \code{killall} sends a
  signal to all processes \code{fork}ed during the current session.
}
\usage{
kill(pid, signal = 15)
killall(signal = 15)
}
\arguments{
  \item{pid}{Process ID for the target process}
  \item{signal}{Signal number to send.  Defaults to 9 (SIGKILL)}
}
\details{
  The \code{kill} function provides a thin wrapper around the Unix
  "kill" system call, which sends a signal to the specified process.  The
  \code{killall} function sends a signal to all processes which have
  been \code{forked} during the current session.

  Refer to the local Unix man pages for details.
}
\value{
  \code{kill} returns 0 on successful completion, -1 on errors.
  \code{killall} does not return a value.
}
\references{"kill" and "waitpid"  man pages}
\author{ Gregory R. Warnes \email{greg@warnes.net}}
\seealso{\code{\link{getpid}}, \code{\link{exit}}, \code{\link{wait}},
         \code{\link{kill}}, \code{\link{killall}} }
\examples{

   # start a process that just sleeps for 10 seconds
    sleepy <- function() 
     {
       cat("Going to sleep..")
       Sys.sleep(10)
       cat("Woke up!")
     }
   pid <- fork( sleepy )

   # kill the sleeping process
   kill(pid)


}
\keyword{programming}

