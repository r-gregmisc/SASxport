\name{signal}
\alias{signal}
\title{Enable or disable handling of signals}
\description{ 
  This function allows enabling or disabling handling of the specified signal.
}
\usage{
signal(signal, action = c("ignore", "default"))
}
\arguments{
  \item{signal}{Signal handler to manipulate, either as a numeric id or
    character mnemonic}
  \item{action}{Either "ignore" or "default"}
}
\details{
  It is occasionally necessary to instruct the R process to ignore
  certain signals.  This function allows changing the status of a signal
  to either igore the signal (SIG\_IGN="ignore") or to the OS's default
  handler (SIG\_DFL="default")  
}
\value{
  Nothing of interest.
}
\references{ See the unix man page for "signal" for more information}
\author{Gregory R. Warnes \email{greg@warnes.net},
  with financial support from Metrum Research Group, LLC
  \url{http://www.metrumrg.com}.
}
\note{
  Be very careful with this function.  It can be used to totally
  confuse the R process.

  On sytems derived from BSD UNIX, setting the SIGCHLD signal to
  'ignore' will allow child processes to exit cleanly without becoming
  zombies.  This also prevents the parent process from checking the exit
  status of children, since this information is no longer available once
  child process disappears. On systems derived from SysV UNIX, setting
  SIGCHLD to 'ignore' has no effect on the status of child processes
  that exit, and they will still become zombies unless the exit status
  is checked.  See the \code{handleSIGCLD} function for a mechanism that
  will prevent child processes from becoming zombies on both SYSV and
  (hopefully) BSD-derived systems.
}
\seealso{  \code{\link{sigval}}, \code{\link{fork}}, \code{\link{handleSIGCLD}} }
\examples{
\dontrun{
## Ignore child termination signals for forked processes NOTE: This
## mechanism only works on UNIX SYSV-derived systems. See Note above.
signal("SIGCHLD","ignore")

# Fork off a child process to say "Hi!".
 {
    pid = fork(slave=NULL) 
    if(pid==0) {
      # only runs in the child process
      cat("Hi from the child process!\n");
      exit() # force process to die
    } 
 } 
}
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{programming}
