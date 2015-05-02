# Restore the original SIGCLD hander. This reverses the action of 'handleSIGCLD'.
restoreSIGCLD <- function()
  {
    .C("R_restore_sigcld_handler", PACKAGE="fork")
    invisible(NULL)
  }
