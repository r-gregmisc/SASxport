# setup a a 'dummy' SIGCLD hander to handle child process
# notifications. Hopefully on both BSD and Sys5 derived systems, this
# should cause child processes to exit and die cleanly, IE without
# becoming zombies.

handleSIGCLD <- function()
  {
    .C("R_install_sigcld_handler", PACKAGE="fork")
    invisible(NULL)
  }
