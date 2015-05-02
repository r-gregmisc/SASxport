#include "RFr3.h"

/* 
   Miscenaneous Routines used in constructing trees and error estimations 
*/

/* BUILDTREE ROUTINE */
void bw_buildtree(double *x, int *colList, double *sampleValues, int *samplePos,
				  int *ycl, int *mdim, int *nsample, int *nclass, int *treemap,
				  int *bestvar, double *xbestsplit,
				  double *dgini, int *nodestatus,
				  int *nodepop, int *nodestart, double *classpop, double *tclasspop,
				  int *nrnodes, int *ndsize, int *nbs,
				  int *mtry, int *mbs, int *mreplace,
				  int *nodeclass, int *ndbigtree, double *win, double *wr, double *wl, int *nuse,
				  int *mperm, int *jstat, int *nbest, int *ndstart, int *ndend, int *wGini,
				  int *Vote, double *tnodewt
				  )
{
  int j, ncur, kbuild, nc;
  double pp, pop, popL, popR;

  memcpy(classpop, tclasspop, (*nclass)*sizeof(classpop[0]));

  /* estimate root nodestatus: nodestatus[0] */
  nodestatus[0] = 2;
  pop = classpop[0];
  for(j=1; j < *nclass; j++){
    pop += classpop[j];
  }
  /* estimate root node class: nodeclass[0] */
  nodeclass[0] = 0; pp = classpop[0];
  for(j=1; j < *nclass; j++){
	if( (classpop[j] - pp) > eps ){
		pp = classpop[j];
		nodeclass[0] = j;
	}
  }
  /* pp = max population of class; pop = population of all class */
  if( (pop-pp) < eps ) nodestatus[0] = -1;
  if(*nuse <= *ndsize) nodestatus[0] = -1;

  nodestart[0] = 0;
  nodepop[0] = *nuse;

  if(*Vote == 3){
   tnodewt[0] = pp/pop;
  }

  /* only when root node can be split */
  if(nodestatus[0] == 2){
    ncur = 0;
    /* main loop over each node ------------------------------------------ */
    for(kbuild=0; kbuild < *nrnodes; kbuild++){
      if(kbuild > ncur) break;
      if(nodestatus[kbuild] != 2) continue;

      /* initialize for next call to FINDBESTSPLIT */
      *ndstart = nodestart[kbuild]; /* relative to colList */
      *ndend = *ndstart + nodepop[kbuild] - 1;
       memcpy(tclasspop, classpop + kbuild*(*nclass), (*nclass)*sizeof(tclasspop[0]));

      /* indicator of terminal node: assume non-terminal first */
      *jstat=0;

      /* FINDBESTSPLIT */
      bw_findbestsplit(x,colList,ycl,mdim,nsample,nclass,
					   ndstart,ndend,tclasspop,bestvar+kbuild,dgini+kbuild,wGini,
					   nbest,xbestsplit+kbuild,
					   jstat,mtry,mbs,mreplace,win,
					   wr,wl,mperm,sampleValues,samplePos
					   );

	  /*
        for *mtry randomly selected variables, they didn't split the node.
	    ==> it's terminal, estimate nodeclass[kbuild] & continue to next node
	  */
      if(*jstat == 1){
		nodestatus[kbuild] = -1;
        /* first node being terminal (one-node tree) */
		if(kbuild == 0){
		  break;
		}
		/* (non-root) terminal node: estimate nodeclass[kbuild] & continue to next node */
		else{
		  nodeclass[kbuild] = 0;
		  pp = classpop[kbuild*(*nclass)];
		  pop = pp;
		  for(j=1; j < *nclass; j++){
			pop += classpop[kbuild*(*nclass) + j];
			if( (classpop[kbuild*(*nclass) + j] - pp) > eps ){
			   pp = classpop[kbuild*(*nclass) + j];
			   nodeclass[kbuild] = j;
			}
		  }
		  if(*Vote == 3){
			  tnodewt[kbuild] = pp/pop;
		  }
		  continue;
		}
      }
	  else{ /* internal node */
		nodestatus[kbuild] = 1;
        treemap[kbuild*2] = ncur+1;
        treemap[kbuild*2 + 1] = ncur+2;
	  }

      /* leftnode = ncur+1 [ndstart:nbest]; rightnode = ncur+2 [(nbest+1):ndend] */
      nodepop[ncur+1] = *nbest - *ndstart + 1;
      nodepop[ncur+2] = *ndend - *nbest;
      nodestart[ncur+1] = *ndstart;
      nodestart[ncur+2] = *nbest + 1;
      nodestatus[ncur+1] = 2;
      nodestatus[ncur+2] = 2;

	  /*
        estimate classpop[ncur+1], classpop[ncur+2]
	    classpop has been initialized to zero beforehand
	  */
	  popL = popR = 0.0;
      for(j=*ndstart; j <= *nbest; j++){
		nc = colList[j];
		classpop[(ncur+1)*(*nclass) + ycl[nc]] += win[nc];
		popL += win[nc];
      }
      for(j=*nbest+1; j <= *ndend; j++){
		nc = colList[j];
		classpop[(ncur+2)*(*nclass) + ycl[nc]] += win[nc];
		popR += win[nc];
      }
	  /* estimate nodeclass[ncur+1], nodeclass[ncur+2] */
	  pp = classpop[(ncur+1)*(*nclass)]; nodeclass[ncur+1] = 0;
	  pop = classpop[(ncur+2)*(*nclass)]; nodeclass[ncur+2] = 0;
      for(j=1; j < *nclass; j++){
		 if( (classpop[(ncur+1)*(*nclass) + j] - pp) > eps ){
			 pp = classpop[(ncur+1)*(*nclass) + j];
			 nodeclass[ncur+1] = j;
		 }
		 if( (classpop[(ncur+2)*(*nclass) + j] - pop) > eps ){
			 pop = classpop[(ncur+2)*(*nclass) + j];
			 nodeclass[ncur+2] = j;
		 }
      }
      /* if samples in the node come from one same class, no more split */
	  if( (popL-pp) < eps ) nodestatus[ncur+1] = -1;
	  if( (popR-pop) < eps ) nodestatus[ncur+2] = -1;

	  if(*Vote == 3){
		tnodewt[ncur+1] = pp/popL;
		tnodewt[ncur+2] = pop/popR;
	  }

	  /* if the size of the node is smaller than pre-specified level, no more split */
      if(nodepop[ncur+1] <= *ndsize) nodestatus[ncur+1] = -1;
      if(nodepop[ncur+2] <= *ndsize) nodestatus[ncur+2] = -1;

      ncur += 2; /* total number of nodes up to now [0:ncur] */
      if(ncur >= (*nrnodes-1)) break; /* seldom happens */
    }
  }

  *ndbigtree = *nrnodes;
  /*
    It's important to initizlize "nodestatus" vector to zero at begining
    *ndbigtree =  actual size of the tree
  */
  for(j=(*nrnodes-1); j >= 0; j--){
    if(nodestatus[j] == 0) *ndbigtree -= 1;
    /* if(nodestatus[j] == 2) nodestatus[j] = -1;  impossible !!! */
  }

}


/* FINDBESTSPLIT ROUTINE */
void bw_findbestsplit(double *x, int *colList, int *ycl, int *mdim, int *nsample, int *nclass,
		      int *ndstart, int *ndend, double *tclasspop, int *msplit, double *decsplit, int *wGini,
		      int *nbest, double *xbestsplit,
			  int *jstat, int *mtry, int *mbs, int *mreplace, double *win,
		      double *wr, double *wl, int *mperm, double *sampleValues, int *samplePos
		      )
{
  int j, mv, mvar, nsp, nl, nr, kL;
  double pno, pdo, crit0, critmax, rrn, rrd, rln, rld, u, crit;

  /* compute initial value of numerator and denominator of Gini */
  pdo = tclasspop[0];
  pno = pow(pdo, 2);
  for(j=1; j < *nclass; j++){
    pno += pow(tclasspop[j], 2);
    pdo += tclasspop[j];
  }
  crit0 = pno/pdo;
  *jstat = 0;

  /* main loop through random selected variables to find best split */
  critmax = -2;

  bw_sample(mdim, mreplace, mperm, mtry, mbs); /* sample without replacement: mreplace=0 */

  for(mv=0; mv < *mtry; mv++){
    mvar = mbs[mv];
    rrn = pno;
    rrd = pdo;
    rln = 0;
    rld = 0;
    memset(wl, 0, (*nclass)*sizeof(wl[0]));
    memcpy(wr, tclasspop, (*nclass)*sizeof(wr[0]));

	for(nsp=*ndstart; nsp <= *ndend; nsp++){
	  sampleValues[nsp] = x[colList[nsp]*(*mdim) + mvar];
	  samplePos[nsp] = nsp;
	} /* samplePos = ndstart:ndend */
	rsort_with_index(sampleValues + *ndstart, samplePos + *ndstart, *ndend - *ndstart + 1);

    for(nsp=*ndstart; nsp < *ndend; nsp++){
	  nl = colList[samplePos[nsp]];
	  nr = colList[samplePos[nsp+1]];
      u = win[nl];
      kL = ycl[nl];
      rln += u*(2*wl[kL]+u);
      rrn += u*(-2*wr[kL]+u);
      rld += u;
      rrd -= u;
      wl[kL] += u;
      wr[kL] -= u;

      /* only when these two nearby samples have different (x) value */
      if( (sampleValues[nsp+1] - sampleValues[nsp]) > eps ){
		if(kL != ycl[nr]){
		  /*
		    only if two nearby samples have different class (ycl) (reduce unnecessary splits)
		    because this situation is always worse than previous or next possible split
		  */
		  if(fmin2(rrd, rld) > eps){
			/* only if both two children nodes contain samples */
			crit = rln/rld + rrn/rrd;
			if( (crit - critmax) > eps ){
			  *nbest = nsp;
			  critmax = crit;
			  *msplit = mvar;
			  /*
			    nbest: best sample value to split on
			    msplit: best variable to split on
			  */
			}
		  }
		}
      }
    }
  }

 /*
   only possible for no split, critmax = -2 (original value)
   split: jstat=0; no split: jstat=1 (terminal node)
 */
  if(critmax < -1){
    *jstat = 1;
  }
  else{
	/*
	  this node can be split, and we need to arrange colList[ndstart:ndend]
      here *decsplit is actually multiplied by sample size pdo
	  *decsplit/pdo is the real decrease of Gini
	*/
	if(*wGini > 0){
	  *decsplit = critmax - crit0;
	}
	else{
	  *decsplit = (critmax - crit0)/pdo;
	}
	/* sort colList[ndstart:ndend] using the increasing order of selected feature x[msplit,colList[ndend:ndstart]] */
	for(nsp=*ndstart; nsp <= *ndend; nsp++){
	  sampleValues[nsp] = x[colList[nsp]*(*mdim) + *msplit];
	}
    rsort_with_index(sampleValues + *ndstart, colList + *ndstart, *ndend - *ndstart + 1);
	*xbestsplit=(sampleValues[*nbest] + sampleValues[*nbest+1])/2.0;
  }

}


/* SUBROUTINE GETWEIGHTS: use class proportions in each terminal node */
void bw_tnprop(int *nclass, int *nodestatus, int *nodeclass, double *classpop,
               int *ndbigtree, double *tnodewt
			   )
{
  int n, j;
  double pop;

  for(n=0; n < *ndbigtree; n++){
	if(nodestatus[n] == -1){
	  pop = classpop[n*(*nclass)];
	  for(j=1; j < *nclass; j++){
		pop += classpop[n*(*nclass)+j];
	  }
	  tnodewt[n] = classpop[n*(*nclass) + nodeclass[n]]/pop;
	}
  }

}

/* SUBROUTINE GETWEIGHTS */
void bw_getweights(double *x, int *nsample, int *mdim, int *treemap, int *nodestatus,
				   double *xbestsplit, int *bestvar, int *nrnodes, int *ndbigtree,
				   int *jin, double *win, double *tw, double *tn, double *tnodewt
				   )
{
  int n, kt, k;

  /*
   for each sample n,
   (1) find its "terminal load: kt (node index)" in the constructed tree
   (2) let tw[kt] += win[k]; tn[kt] += jin[kt]; (different samples may end up in the same terminal node)
   <==> find node size for each terminal node of current tree (using weight "win" and count "jin")
   implemented by allocating all samples into terminal nodes
  */
  for(n=0; n < *nsample; n++){
	/* inb (Bootstrap) samples */
    if(jin[n] >= 1){
	  /* current node: start from root */
      kt = 0;
      /* *ndbigtree = actual number of nodes in the tree > max number of nodes browsed by one sample */
      for(k=0; k < *ndbigtree; k++){
		/* reach a terminal node; stop searching */
		if(nodestatus[kt] == -1){
		  tw[kt] += win[n];
		  tn[kt] += jin[n];
		  break;
		}
		if( (xbestsplit[kt] - x[n*(*mdim) + bestvar[kt]]) > eps ){
		  kt = treemap[kt*2];
		}
		else{
		  kt = treemap[kt*2 + 1];
		}
      }
    }
  }

  for(n=0; n < *nrnodes; n++){
	/* tnodewt: average weight of all samples in a terminal node for current tree */
    if(nodestatus[n] == -1){
	  tnodewt[n] = tw[n]/tn[n];
	}
  }

}

/* TESTREEBAG ROUTINE */
void bw_testreebag(double *x, int *nts, int *mdim, int *treemap, 
				   int *nodestatus, double *xbestsplit, int *bestvar, int *nodeclass,
				   int *ndbigtree, int *jts, int *nodex,
				   int *jin, double *dgini, double *minbgini, double *moobgini
				   )
{
  int n, kt, k;

  for(n=0; n < *nts; n++){
	/* "kt" will track the path of putting sample "n" down current tree */
    kt = 0;
    for(k=0; k < *ndbigtree; k++){
      /* reach a terminal node "kt" in curret tree */
      if(nodestatus[kt] == -1){
        /* class prediction for sample n */
		jts[n] = nodeclass[kt];
        /* sample "n" lands in terminal node "kt"; goto to next sample */
		nodex[n] = kt;
		break;
      }

	  /* inb (Bootstrap) samples in current tree */
      if(jin[n] > 0){
		minbgini[bestvar[kt]] += dgini[kt];
      }
	  /* oob (Bootstrap left-out) samples */
      else{
		moobgini[bestvar[kt]] += dgini[kt];
      }
      if( (xbestsplit[kt] - x[n*(*mdim) + bestvar[kt]]) > eps ){
		kt = treemap[kt*2];
      }
      else{
		kt = treemap[kt*2 + 1];
      }
    }
  }

}


/* PERMUTE OBS: out-of-bag samples are permuted at their original location for feature "mr" */
void bw_permobmr(int *mr, double *x, double *tp, double *tx, int *jin,
				 int *nsample, int *nperm, int *mdim, int *nperm1
				 )
{
  int kout, n, iout;
  int replace = 0; /* permutation: no replacement */

  /* memset(tp, 0, (*nsample)*sizeof(tp[0]));  no need */
  kout = 0;

  for(n=0; n < *nsample; n++){
	/* OOB samples */
    if(jin[n] == 0){
      tp[kout] = x[n*(*mdim) + *mr];
      kout++;
    }
  }

  bw_sample(&kout, &replace, nperm1, &kout, nperm); /* reuse nperm[0:(kout-1)] */

  iout = 0;
  for(n=0; n < *nsample; n++){
    tx[n] = x[n*(*mdim) + *mr]; /* tx keeping original value of x[mr,n] for late restore */
    if(jin[n] == 0){
      x[n*(*mdim) + *mr] = tp[nperm[iout]]; /* x being permuted */
      iout++;
    }
  }

}

/* ERROR COMPUTING */
void bw_comperrtr(double *counttr, int *ycl, int *nclass, int *nc, int *nsample,
                  double *tmiss
				  )
{
  int n, j, jmax = 0;
  double errtr=0.0, cmax;

  memset(tmiss, 0, (*nclass)*sizeof(tmiss[0]));

  for(n=0; n < *nsample; n++){
    cmax = counttr[n*(*nclass)];
	jmax = 0;
    for(j=1; j < *nclass; j++){
      if( (counttr[n*(*nclass) + j] - cmax) > eps ){
		jmax = j;
		cmax = counttr[n*(*nclass) + j];
      }
    }
    if(jmax != ycl[n]){
      tmiss[ycl[n]] += 1.0;
      errtr += 1.0;
    }
  }
  errtr /= *nsample;
  Rprintf("Training Error: %5.4f;  ", errtr);
  for(j=0; j < *nclass; j++){
    Rprintf("Class %d Error: %5.4f;  ", j, tmiss[j]/nc[j]);
  }
  Rprintf("\n");

}

/* FINISH IMPORTANCE */
void bw_finishimp(int *ycl, double *counttr, int *nclass, int *nsample,
				  double *countimp, int *mdim, double *diffmarg, double *tmissimp
				  )
{
  double pop, rmax, mpop;
  int n, m, j, index, imax;
  double *rimpmarg, *rmarg;

  rmarg    = (double *) Calloc(*nsample, double);
  rimpmarg = (double *) Calloc((*nsample)*(*mdim), double);
  memset(tmissimp, 0, (*mdim)*sizeof(tmissimp[0]));

  /*
   calculate margin for each sample in RF prediction without permutation
   margin(n) = p(true group) - max p(other group)
  */
  for(n=0; n < *nsample; n++){
    pop = 0.0;
    for(j=0; j < *nclass; j++){
      if(j != ycl[n]){
		pop = fmax2(pop, counttr[n*(*nclass) + j]);
      }
    }
    rmarg[n] = counttr[n*(*nclass) + ycl[n]] - pop;
  }

  /* normalize the prediction array from permutation for each feature */
  for(m=0; m < *mdim; m++){
    for(n=0; n < *nsample; n++){
	  pop = countimp[m*(*nsample)*(*nclass) + n*(*nclass)];
	  for(j=1; j < *nclass; j++){
		pop += countimp[m*(*nsample)*(*nclass) + n*(*nclass) + j];
	  }
      for(j=0; j < *nclass; j++){
		countimp[m*(*nsample)*(*nclass) + n*(*nclass) + j] /= pop;
      }
    }
  }

  /* Calculate margin difference for each samples (for each feature permutation) */
  for(m=0; m < *mdim; m++){
    for(n=0; n < *nsample; n++){
      rmax = -1.0; imax = -1;
      pop = -1.0;
      for(j=0; j < *nclass; j++){
		index = m*(*nsample)*(*nclass) + n*(*nclass) + j;
		if( (countimp[index] - rmax) > eps ){
		  rmax = countimp[index];
		  imax = j;
		}
		if(j != ycl[n]){
		  pop = fmax2(pop, countimp[index]);
		}
      }
	  /* number of miss-classifications for each class caused by permuting feature m */
      if(imax != ycl[n]){
		tmissimp[m*(*nclass) + ycl[n]] += 1.0;		
      }
      index = m*(*nsample)*(*nclass) + n*(*nclass) + ycl[n];
      rimpmarg[m*(*nsample) + n] = countimp[index] - pop;
    }
  }

  pop = rmarg[0];
  for(j=1; j < *nsample; j++){
	pop += rmarg[j];
  }
  for(m=0; m < *mdim; m++){
    mpop = rimpmarg[m*(*nsample)];
    for(n=1; n < *nsample; n++){
	  mpop += rimpmarg[m*(*nsample) + n];
    }
	/* decrease of margin due to permuting feature m */
    diffmarg[m] = (pop - mpop)/(*nsample);
  }

  Free(rmarg);
  Free(rimpmarg);  

}
