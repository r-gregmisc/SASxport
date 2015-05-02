/*
  Define all kinds of subroutines used in the program here, to make program structure nice.
*/

#include <R.h>
#include <Rmath.h>
#include <string.h>
#include <math.h>
#define eps 1.0e-6
#define REXE1
#ifdef REXE
#define Rprintf printf
#define GetRNGstate() printf(" ")
#define PutRNGstate() printf(" ")
#endif

/* main */
void bw_RF(int *, int *, int *, double *, int *,
		   double *, int *, int *,
		   int *, int *, int *, int *, int *, int *,
		   int *, double *, int *, int *,
		   int *, int *,
		   int *, int *, int *,
		   double *, int *, double *,
		   double *, double *,
		   double *, double *, double *, double *, int *,
		   int *, int *, double *, int *, int *
		   );

/* sub1 */
void bw_sample(int *, int *, int *, int *, int *);
void bw_PrbRep(int *, double *, int *, int *, int *);
void bw_Prb(int *, double *, int *, int *, int *);

/* sub2 */
void bw_buildtree(double *, int *, double *, int *,
				  int *, int *, int *, int *, int *,
				  int *, double *,
				  double *, int *,
				  int *, int *, double *, double *,
				  int *, int *, int *,
				  int *, int *, int *,
				  int *, int *, double *, double *, double *, int *,
				  int *, int *, int *, int *, int *, int *,
				  int *, double *
				  );
void bw_findbestsplit(double *, int *, int *, int *, int *, int *,
					  int *, int *, double *, int *, double *, int *,
					  int *, double *,
					  int *, int *, int *, int *, double *,
					  double *, double *, int *, double *, int *
					  );
void bw_tnprop(int *, int *, int *, double *,
               int *, double *
			   );
void bw_getweights(double *, int *, int *, int *, int *,
				   double *, int *, int *, int *,
				   int *, double *, double *, double *, double *
				   );
void bw_testreebag(double *, int *, int *, int *,
				   int *, double *, int *, int *,
				   int *, int *, int *,
				   int *, double *, double *, double *
				   );
void bw_permobmr(int *, double *, double *, double *, int *,
				 int *, int *, int *, int *
				 );
void bw_comperrtr(double *, int *, int *, int *, int *, double *);
void bw_finishimp(int *, double *, int *, int *,
				  double *, int *, double *, double *
				  );
