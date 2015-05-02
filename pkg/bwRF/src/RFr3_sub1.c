#include "RFr3.h"

/* %%%%%%%%%%%%%%%%%% Sampling Routines %%%%%%%%%%%%%%%%%%%% */
/* Equal Probability Sampling */
void bw_sample(int *n, int *replace, int *perm, int *nans, int *ans)
{
  int i, j, nn=*n;
  
  if(*replace > 0){
    for(i=0; i < *nans; i++){
      ans[i] = unif_rand()*nn;
    }
  }
  else{
    /* important to do this beforehand each time */
    for(i=0; i < nn; i++){
      perm[i] = i;
    }

    for(i = 0; i < *nans; i++){
      j = unif_rand()*nn;
      ans[i] = perm[j];
      nn--;
      perm[j] = perm[nn];   /* extra-ordinary smart */
    }
  }
  
}

/* Unequal probability sampling; with-replacement case */
void bw_PrbRep(int *n, double *p, int *perm, int *nans, int *ans)
{
  double random;
  int i, j;
  int nm1 = *n - 1;

  /* record element identities */
  for (i = 0; i < *n; i++)
    perm[i] = i;

  /* sort the probabilities into descending order */
  revsort(p, perm, *n);

  /* compute cumulative probabilities */
  for (i = 1 ; i < *n; i++)
    p[i] += p[i - 1];

  /* compute the sample */
  for (i = 0; i < *nans; i++) {
    random = unif_rand();
    for (j = 0; j < nm1; j++) {
      if (random <= p[j])	break;
    }
    ans[i] = perm[j]; /* it's possible that j=nm1 */
  }

}

/* Unequal probability sampling; without-replacement case */
void bw_Prb(int *n, double *p, int *perm, int *nans, int *ans)
{
  double random, mass, totalmass;
  int i, j, k, nm1;

  /* Record element identities */
  for (i = 0; i < *n; i++){
    perm[i] = i;
  }

  /* Sort probabilities into descending order */
  /* Order element identities in parallel */
  revsort(p, perm, *n);

  /* Compute the sample */
  totalmass = 1.0;
  for (i = 0, nm1 = *n-1; i < *nans; i++, nm1--) {
    random = totalmass * unif_rand();
    mass = 0.0;
    for (j = 0; j < nm1; j++) {
      mass += p[j];
      if (random <= mass)	break;
    }
    ans[i] = perm[j];
    totalmass -= p[j];
    if(j < nm1){ /* if j=nm1, no need to change p */
      for(k = j; k < nm1; k++) { /* p[j:(nm1-1)] <- p[(j+1):nm1] */
		p[k] = p[k + 1];
		perm[k] = perm[k + 1];
      }
    }
  }

}

