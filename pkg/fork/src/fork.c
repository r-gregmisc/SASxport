/* $Id$ */

/*************************************************************/
/* Simple wrappers around the fork, getpid, kill, _exit, and */
/* wait Unix API calls for use with R.                       */
/*************************************************************/

#include <R.h>
#include <Rdefines.h>

#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <signal.h>

void Rfork_fork(int *pid)
{
  *pid = (int) fork();
}

void Rfork_getpid(int *pid)
{
  *pid = (int) getpid();
}


void Rfork_kill(int *pid, int *signal, int *flag)
{
  *flag = kill(*pid, *signal);
}

void Rfork__exit(int *status)
{
  _exit(*status);
}

void Rfork_waitpid(int *pid, int *nohang, int *untraced, int *status)
{
  int options=0;
  int pidnew=0;
  if(*nohang)    options |= WNOHANG;
  if(*untraced)  options |= WUNTRACED;

  *pid = waitpid( *pid, status, options);
}
  

void Rfork_wait(int *pid, int *status)
{
  *pid = wait(status);
}
  

/* The type definitions for the table of signal constants */
typedef struct {
  char   *name;  /* signal name */
  int    val;    /* value (0 means not defined) */
  char   *desc;  /* Text description */
} SIGTAB;

/* Table of signal constants.  The values change by OS and CPU so we
   have to look them up here rather than having static definitions in
   the R code. */

SIGTAB sigtab[] = {
#ifdef SIGHUP
  {"SIGHUP",     SIGHUP,     "Hangup"},    
#endif
#ifdef SIGINT
  {"SIGINT",     SIGINT,     "Interrupt"},    
#endif
#ifdef SIGQUIT
  {"SIGQUIT",    SIGQUIT,    "Quit"},    
#endif
#ifdef SIGILL
  {"SIGILL",     SIGILL,     "Illegal Instruction"},    
#endif
#ifdef SIGTRAP
  {"SIGTRAP",    SIGTRAP,    "Trace or Breakpoint Trap"},    
#endif
#ifdef SIGABRT
  {"SIGABRT",    SIGABRT,    "Abort"},    
#endif
#ifdef SIGEMT
  {"SIGEMT",     SIGEMT,     "Emulation Trap"},    
#endif
#ifdef SIGFPE
  {"SIGFPE",     SIGFPE,     "Arithmetic Exception"},    
#endif
#ifdef SIGKILL
  {"SIGKILL",    SIGKILL,    "Killed"},    
#endif
#ifdef SIGBUS
  {"SIGBUS",     SIGBUS,     "Bus Error"},    
#endif
#ifdef SIGSEGV
  {"SIGSEGV",    SIGSEGV,    "Segmentation Fault"},    
#endif
#ifdef SIGSYS
  {"SIGSYS",     SIGSYS,     "Bad System Call"},    
#endif
#ifdef SIGPIPE
  {"SIGPIPE",    SIGPIPE,    "Broken Pipe"},    
#endif
#ifdef SIGALRM
  {"SIGALRM",    SIGALRM,    "Alarm Clock"},    
#endif
#ifdef SIGTERM
  {"SIGTERM",    SIGTERM,    "Terminated"},    
#endif
#ifdef SIGUSR1
  {"SIGUSR1",    SIGUSR1,    "User Signal 1"},    
#endif
#ifdef SIGUSR2
  {"SIGUSR2",    SIGUSR2,    "User Signal 2"},    
#endif
#ifdef SIGCHLD
  {"SIGCHLD",    SIGCHLD,    "Child Status Changed"},    
#endif
#ifdef SIGPWR
  {"SIGPWR",     SIGPWR,     "Power Fail or Restart"},    
#endif
#ifdef SIGWINCH
  {"SIGWINCH",   SIGWINCH,   "Window Size Change"},    
#endif
#ifdef SIGURG
  {"SIGURG",     SIGURG,     "Urgent Socket Condition"},    
#endif
#ifdef SIGPOLL
  {"SIGPOLL",    SIGPOLL,    "Pollable Event"},    
#endif
#ifdef SIGSTOP
  {"SIGSTOP",    SIGSTOP,    "Stopped (Signal)"},    
#endif
#ifdef SIGTSTP
  {"SIGTSTP",    SIGTSTP,    "Stopped (User)"},    
#endif
#ifdef SIGCONT
  {"SIGCONT",    SIGCONT,    "Continued"},    
#endif
#ifdef SIGTTIN
  {"SIGTTIN",    SIGTTIN,    "Stopped (tty input)"},    
#endif
#ifdef SIGTTOU
  {"SIGTTOU",    SIGTTOU,    "Stopped (tty output)"},    
#endif
#ifdef SIGVTALRM
  {"SIGVTALRM",  SIGVTALRM,  "Virtual Timer Expired"},    
#endif
#ifdef SIGPROF
  {"SIGPROF",    SIGPROF,    "Profiling Timer Expired"},    
#endif
#ifdef SIGXCPU
  {"SIGXCPU",    SIGXCPU,    "CPU Time limit Exceeded"},    
#endif
#ifdef SIGXFSZ
  {"SIGXFSZ",    SIGXFSZ,    "File Size Limit Exceeded"},    
#endif
#ifdef SIGWAITING
  {"SIGWAITING", SIGWAITING, "Concurrency Signal Reserved by Threads Library"},
#endif
#ifdef SIGLWP
  {"SIGLWP",     SIGLWP,     "Inter-LWP Signal Reserved by Threads Library"},    
#endif
#ifdef SIGFREEZE
  {"SIGFREEZE",  SIGFREEZE,  "Check Point Freeze"},    
#endif
#ifdef SIGTHAW
  {"SIGTHAW",    SIGTHAW,    "Check Point Thaw"},
#endif
#ifdef SIGIOT
  {"SIGIOT",     SIGIOT,     "IOT trap. (Synonym for SIGABRT)"},
#endif
#ifdef SIGSTKFLT
  {"SIGSTKFLT",  SIGSTKFLT,  "Stack Fault on Coprocessor"},
#endif
#ifdef SIGIO
  {"SIGIO",      SIGIO,      "I/O Now Possible (4.2 BSD}"},
#endif
#ifdef SIGCLD
  {"SIGCLD",     SIGCLD,     "Child Status Changed (Synonym for SIGCHLD}"},
#endif
#ifdef SIGINFO
  {"SIGINFO",    SIGINFO,    "Power Fail or Restart (Synonym for SIGPWR}"},
#endif
#ifdef SIGLOST
  {"SIGLOST",    SIGLOST,    "File Lock Lost"},
#endif
#ifdef SIGUNUSED
  {"SIGUNUSED",  SIGUNUSED,  "Unused Signal (Will Be SIGSYS}"},
#endif
  {"",           -1,         "Unknown or Undefined Signal"} /* end mark */
};

void Rfork_siginfo(char **name, int *val, char **desc)
{
  SIGTAB *ptr=sigtab;

  while( ptr->val != -1 )
    {
      if(strcmp(*name, ptr->name)==0)
	{
	  *val = ptr->val;
	  *desc = ptr->desc;
	  return;
	}
      ptr++;
    }

  error("Unknown or undefined signal name %s", *name);
}

void Rfork_signame(char **name, int *val, char **desc)
{
  SIGTAB *ptr=sigtab;

  while( ptr->val != -1 )
    {
      if(*val == ptr->val )
	{
	  *name = ptr->name;
	  *desc = ptr->desc;
	  return;
	}
      ptr += 1;
    }

  error("Unknown or undefined signal valuee %s", *name);
}

int dummy(){
  return 1;
}

/* Uses R .Call interface */
SEXP Rfork_siglist() 
{ 
  SEXP list, val, name, desc;
  int tablen=1; 
  int index;
  

  /* first find the table length  */
  for( tablen = 0; sigtab[tablen].val != -1; tablen++) {};

  /* allocate the return list  */
  PROTECT( list = allocVector( VECSXP, 3 ) ); 

  /* now allocate sufficient space for the return values  */
  PROTECT( val  = allocVector( INTSXP, tablen) ); 
  PROTECT( name = allocVector( STRSXP, tablen) ); 
  PROTECT( desc = allocVector( STRSXP, tablen) ); 
   
  SET_VECTOR_ELT( list, 0, val  ); 
  SET_VECTOR_ELT( list, 1, name ); 
  SET_VECTOR_ELT( list, 2, desc ); 

  for(index = 0; index < tablen; index++)
    { 
      INTEGER(val)[index] = sigtab[index].val;
      SET_STRING_ELT ( name, index, mkChar(sigtab[index].name)); 
      SET_STRING_ELT ( desc, index, mkChar(sigtab[index].desc)); 
    } 

  UNPROTECT(4); 
  return list; 
} 

void Rfork_signal(int *sig, int *action)
{
  if(*action==0)
    signal( *sig, SIG_IGN );
  else
    signal( *sig, SIG_DFL );

  
}
   
