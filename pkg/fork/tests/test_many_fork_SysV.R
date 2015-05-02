## This script starts child processes, and sets the SIGCHLD hander to
## "ignore".  On Sys5 derived systems, this should cause child
## processes to exit and die cleanly without the parent process
## querying the exit state.  IE, no zombie processes will be created.

library(fork)

## ignore sigchld signals so child processes will die cleanly
signal("SIGCHLD","ignore")

source("checkZombies.R")

nZombies <- checkZombies()

