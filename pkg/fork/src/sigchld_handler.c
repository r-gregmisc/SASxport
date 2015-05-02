#include <R.h>
#include <Rdefines.h>

/*
  Code taken from a posting to the Gimp-developer mailing list by
  Raphael Quinet quinet at gamers.org accessible at:
  http://lists.xcf.berkeley.edu/lists/gimp-developer/2000-November/013572.html
*/

#include <signal.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int installed=0;      // Has our sigcld signal hander already been installed?

struct sigaction sa ; // our sigcld signal handler
struct sigaction osa; // original (R) signal hander

void sigchld_handler(int dummy) 
{
  int st;
  // wait3 returns 0 when no signal is present to retrieve
  while (wait3(&st, WNOHANG, NULL) > 0);
}


void R_install_sigcld_handler()
{
  int ret;

  if(installed==0)
    {
      Rprintf ("Installing SIGCHLD signal handler...");
      sa.sa_handler = sigchld_handler;
      //sigfillset (&sa.sa_mask);
      //sa.sa_flags = SA_RESTART;
      ret = sigaction (SIGCHLD, &sa, &osa);
      if (ret < 0)
	{
	  error("Cannot set signal handler");
	}
      installed=-1;
      Rprintf("Done.\n");
    }
  else
    {
      warning("SIGCLD signal handler already installed");
    }

}

void R_restore_sigcld_handler()
{
  int ret;

  if(installed==-1)
    {
      Rprintf ("Restoring original SIGCHLD signal handler...");
      ret = sigaction (SIGCHLD, &osa, &sa);
      if (ret < 0)
	{
	  error("Cannot reset signal handler");
	}
      installed=0;
      Rprintf("Done.\n");
    }
  else
    {
      warning("SIGCLD signal handler not installed: cannot reset.");
    }

}
