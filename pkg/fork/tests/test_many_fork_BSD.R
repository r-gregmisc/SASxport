## This script starts child processes, and sets up a 'dummy' SIGCLD
## hander to handle child process notifications. Hopefully on both BSD
## and Sys5 derived systems, this should cause child processes to exit
## and die cleanly, IE without becoming zombies.

library(fork)

## start signal handler
handleSIGCLD()

source("checkZombies.R")

nZombies <- checkZombies()

# remove signal handler
restoreSIGCLD()
