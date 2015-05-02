# $Id$

fork <- function(slave)
  
  {
    if(missing(slave) || class(slave)!="function" && !is.null(slave) )
      stop("function for slave process to exectute must be provided.")

    pid  <- .C("Rfork_fork",
               pid=integer(1),
               PACKAGE="fork"
               )$pid

    if(pid==0)
      {
        # the slave shouldn't get a list of the master's children (?)
        if(exists(".pidlist",where=.GlobalEnv))
          remove(".pidlist",pos=.GlobalEnv)
        
        if(!is.null(slave))
          {
            on.exit( { cat("ERROR. Calling exit()..."); exit(); }  );
            slave();
            exit();
          }
      }
    else
      {
        # save all the pid's that get created just in case the user forgets
        # to keep track of them!
        if(!exists(".pidlist",where=.GlobalEnv))
          assign(".pidlist",pid,pos=.GlobalEnv)
        else
          assign(".pidlist",c(.pidlist, pid),pos=.GlobalEnv)
      }

    return(pid)
  }
    
