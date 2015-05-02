checkZombies <- function()
  {
    cat("Generating 100 child processes (to become zombies)...\n")
    pidList <- integer(100)
    for(i in 1:100)
      {
        pid = fork(slave=NULL) 
        if(pid==0)
          { 
            ##cat("Hi from child process",getpid(),".\n");
            ##Sys.sleep(10);
            ##cat("Bye from child process",getpid(),".\n");
            exit() 
          }
        else
          pidList[i] <- pid
      }

    cat("Give them 10 seconds to die and exit..\n")
    Sys.sleep(10)

    cat("Check the process table to see if there are any zombies...\n")
    if(TRUE) # BSD-style 'ps' command (Linux, Mac OSX, NetBSD)
      {
        statusList = system("ps -o stat", intern=TRUE)[-1]
      } else # SysV-style 'ps' command (Solaris)
    {
      statusList = system("ps -o s", intern=TRUE)[-1]
    }

    zombies = grep("[Zz]", statusList, value=TRUE)
    if(length(zombies)>50)
      {
        retval = TRUE
        warning(length(zombies), " Zombie Processes Present!\n")
        cat(length(zombies), " Zombie Processes Present!\n")
      }
    else
      {
        retval = FALSE
        cat("Done. No Zombies present.\n")
      }


    for(i in 1:100)
      wait(pidList[i], nohang=FALSE)
    
    return(retval)
}
