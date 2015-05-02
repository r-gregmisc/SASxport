#include "RFr3.h"

/*
 Better to use Calloc() instead of R_alloc(): Calloc() is modeled after calloc() function in C,
 (1) Calloc() will automatically zero the assigned memory, but we need to manually free it
 (2) Memory allocated from Calloc() is additional to the workspace assined to R
     Instead of manually zero part of memory, use internal C function memset() to do it.
     memcpy() copy between two memory area efficiently! use it!
     Don't claim memory in repeatedly-called sub functions, do them in the main function once and reuse
        the memory
 (3) comparisons better to be done using "a-b > eps" style
*/

void bw_RF(int *ycl, int *nclass, int *nc, double *classwt, int *Vote,
           double *x, int *mdim, int *nsample,
           int *mtry, int *ntree, int *ndsize,
		   int *nbs, int *nreplace, int *mreplace,
		   int *itest, double *xts, int *nts, int *jints,
		   int *ilook, int *nlook,
		   int *iprox, int *iimp, int *ikeepft,
           double *counttr, int *out, double *countts,
		   double *prox, double *tmiss,
		   double *tmissimp, double *diffmarg,
		   double *minbgini, double *moobgini, int *wGini,
		   int *treemap, int *bestvar, double *xbestsplit, int *nodeclass, int *nodestatus
		   )
{
  /*
    ################## INPUT
    ###   Y
    ycl:        class label for nsample
    nclass:     number of possible classes (levels of ycl)
    nc:         number of samples for all classes [1:nclass]
    classwt:    weight specified for different classes (used in tree construction)
	Vote:       method of tree voting
	            1:  simple vote, each tree counting 1
		  		2:  weighted vote using average sample weight of terminal node
		  		3:  probability vote (using proportions of winning class)
    ###   X
    x:          data matrix of "mdim" features by "nsample" samples (training set)
    mdim:       number of features
    nsample:    number of samples (in training set x)
    ###   Tree parameter
    mtry:       number of random features to try at each node split
    ntree:      number of trees to grow
    ndsize:     minimum terminal node size (1 will give a saturated tree, which has good performance)
    nbs:        size of Bootstrap sample set for each (bagging) tree
    nreplace:   Bootstrap samples with/without replacement
    mreplace:   Bootstrap features with/without replacement
    ###   Testing set
    itest:      indicator testing set exists or not
    xts:        data matrix for testing set
    nts:        number of testing samples
    jints:      indicator for predicting which test subset [1:nts]
    ###   Tracing Error information
    ilook:      tracing error or nor
    nlook:      how often to look at the error
    ###   RF extra information
    iimp:       indicator of calculating importance or not
    iprox:      indicator of calculating proximity
    ikeepft:    indicator of keeping forest
    ##################   OUTPUT
    counttr:    OOB vote of all classes for each sample
    out:        total number of OOB vote for each sample
    countts:    vote matrix for testing set xts
    prox:       proximity matrix
    tmiss:      number of miss-classifications for each class
    tmissimp:   number of miss classifications for each class after permuting feature m [nclass, mdim]
                  " a too gross measure; instead we can use posterior probability from countimp,
                    which is a continuous version of tmissimp "
    diffmarg:   total decrease of impurity (Gini, weighted or not) after permuting feature m
                used as an importance measure for each feature
                  " derived from countimp, continuous version of tmissimp "
                    (1) marg = posterior pr(true group) - max posterior pr(other group)
                    (2) diffmarg = \sum marg(without permutation) - \sum marg(after permutation)
                    (3) pp = posterior pr(true group)
                        diffpp = \sum pp(without permutation) - \sum pp(after permutation)
                               <==> diffmarg (if only two groups)
    minbgini:   (weighted) gini decrease for each feature using in-bag samples
    moobgini:   (weighted) gini decrease for each feature using out-of-bag samples
    wGini:      use weighted Gini decrease (default) or not
    treemap:    tree structure (parent-children chain)
    bestvar:    (best) split variable for each node
    xbestsplit: (best) split value for the selected variable
    nodeclass:  class status for every node
    nodestatus: terminal indicator for each node
  */

  /* ##################### Variable Initialization Routine ######################### */
  double *dgini,*tx,*wl,*classpop,*win,*tp,*wr,*tclasspop,*tw,*tn,*tnodewt,
    *countimp, *minbginits,*moobginits, *minbginiimp,*moobginiimp;

  int *nodepop, *jin, *jvr, *iv, *mperm, *nperm,
    *nodex, *nodestart, *jts, *jtr, *nodexts, *mbs;

  int i, k, n, kt, mr, jb, index = 0, array;
  int *xbs, nuse, *ndbigtree;
  
  /* TREE BUILDING PARAMETERS */
  int *jstat, *nbest, *ndstart, *ndend, *colList, *samplePos;
  double *sampleValues, pop;
  
  /* RF parameters */
  int nrnodes;
  nrnodes = 2*(*nsample)/(*ndsize) + 1;
  
  mperm      = (int *) Calloc(*mdim, int);
  nperm      = (int *) Calloc(*nsample, int);
  jstat      = (int *) Calloc(1, int);
  nbest      = (int *) Calloc(1, int);
  ndstart    = (int *) Calloc(1, int);
  ndend      = (int *) Calloc(1, int);
  colList    = (int *) Calloc(*nbs, int); /* used to record unique Bootstrap Sample IDs */
  samplePos  = (int *) Calloc(*nbs, int);
  sampleValues = (double *) Calloc(*nbs, double);
  
  dgini       = (double *) Calloc(nrnodes, double);
  classpop    = (double *) Calloc((*nclass)*nrnodes, double);
  win         = (double *) Calloc(*nsample, double);
  wl          = (double *) Calloc(*nclass, double);
  wr          = (double *) Calloc(*nclass, double);
  tclasspop   = (double *) Calloc(*nclass, double);
  tnodewt     = (double *) Calloc(nrnodes, double);
  
  if(*itest > 0){
    minbginits  = (double *) Calloc(*mdim, double);
    moobginits  = (double *) Calloc(*mdim, double);
  }
  if(*iimp > 0){
    countimp  = (double *) Calloc((*nclass)*(*nsample)*(*mdim), double);
    tx        = (double *) Calloc(*nsample, double);
    tp        = (double *) Calloc(*nsample, double);
    minbginiimp = (double *) Calloc(*mdim, double);
    moobginiimp = (double *) Calloc(*mdim, double);
  }
  if(*Vote == 2){
    tw        = (double *) Calloc(nrnodes, double);
    tn        = (double *) Calloc(nrnodes, double);
  }
  
  nodepop        = (int *) Calloc(nrnodes, int);
  jin            = (int *) Calloc(*nsample, int);
  nodex          = (int *) Calloc(*nsample, int);
  nodestart      = (int *) Calloc(nrnodes, int);
  jtr            = (int *) Calloc(*nsample, int);
  mbs            = (int *) Calloc(*mtry, int);
  xbs            = (int *) Calloc(*nbs, int);
  ndbigtree      = (int *) Calloc(1, int);
  
  if(*itest > 0){
    jts          = (int *) Calloc(*nts, int);  /* testset prediction */
    nodexts      = (int *) Calloc(*nts, int);
  }
  if(*iimp > 0){
    iv           = (int *) Calloc(*mdim, int);
    jvr          = (int *) Calloc(*nsample, int);
  }
  /* ##################### Variable Initialization Routine ######################### */
  
  GetRNGstate();
  
  /* important to zero these memory at beginning: cumulative over Bootstrap Trees */
  memset(counttr, 0, (*nclass)*(*nsample)*sizeof(counttr[0]));
  memset(out, 0, (*nsample)*sizeof(out[0]));
  memset(minbgini, 0, (*mdim)*sizeof(minbgini[0]));
  memset(moobgini, 0, (*mdim)*sizeof(moobgini[0]));
  
  /*
     In future prediction, we use simple count vote of all trees
     probability voting  <<====  "classpop[nclass,ntnodes,ntree]"
  */
  if(*ikeepft > 0){
    memset(treemap, 0, 2*nrnodes*(*ntree)*sizeof(treemap[0]));
    memset(bestvar, 0, nrnodes*(*ntree)*sizeof(bestvar[0]));       /* only for internal nodes */
    memset(xbestsplit, 0, nrnodes*(*ntree)*sizeof(xbestsplit[0])); /* only for internal nodes */
    memset(nodeclass, 0, nrnodes*(*ntree)*sizeof(nodeclass[0]));   /* only for terminal nodes */
    memset(nodestatus, 0, nrnodes*(*ntree)*sizeof(nodestatus[0]));
  }
  if(*itest > 0){
    memset(countts, 0, (*nclass)*(*nts)*sizeof(countts[0]));
  }
  if( *Vote == 1 ){
	/* memset(tnodewt, 1.0, nrnodes*sizeof(tnodewt[0])); */
    for(i=0; i < nrnodes; i++){
      tnodewt[i] = 1.0;
    }
  }
  if(*iimp > 0){
    memset(tmissimp, 0, (*nclass)*(*mdim)*sizeof(tmissimp[0]));
    memset(diffmarg, 0, (*mdim)*sizeof(diffmarg[0]));
  }
  if(*iprox > 0){
    memset(prox, 0, (*nsample)*(*nsample)*sizeof(prox[0]));
  }
  
  /* main loop over each tree ----------------------------------------------- */
  for(jb=0; jb < *ntree; jb++){
    /* Initialize to zero at construction of each tree */
    memset(win, 0, (*nsample)*sizeof(win[0]));
    memset(jin, 0, (*nsample)*sizeof(jin[0]));
    memset(tclasspop, 0, (*nclass)*sizeof(tclasspop[0]));
	/*
	  memset(nodestart, 0, nrnodes*sizeof(nodestart[0]));
	  memset(nodepop, 0, nrnodes*sizeof(nodepop[0]));
	*/
    memset(classpop, 0, (*nclass)*nrnodes*sizeof(classpop[0]));
	
    if(*ikeepft < 1){
      memset(treemap, 0, 2*nrnodes*sizeof(treemap[0]));
      memset(bestvar, 0, nrnodes*sizeof(bestvar[0]));
      memset(xbestsplit, 0, nrnodes*sizeof(xbestsplit[0]));
      memset(nodeclass, 0, nrnodes*sizeof(nodeclass[0]));
      memset(nodestatus, 0, nrnodes*sizeof(nodestatus[0]));
    }
	
    bw_sample(nsample, nreplace, nperm, nbs, xbs);
    for(i=0; i < *nbs; i++){
      k = xbs[i];
      win[k] += classwt[ycl[k]];
      jin[k] += 1;
      tclasspop[ycl[k]] += classwt[ycl[k]];
    }
	
    nuse = 0;
    for(i=0; i < *nsample; i++){
      if(jin[i] >= 1){
		  colList[nuse] = i; /* colList[1:nuse] record unique Bootstrap sample IDs */
		  nuse++;
	  }
    }
	
    /* TREE BUILDING */
    array = nrnodes*jb*(*ikeepft);
    bw_buildtree(x, colList, sampleValues, samplePos,
				 ycl, mdim, nsample, nclass, treemap+2*array,
				 bestvar+array, xbestsplit+array,
				 dgini, nodestatus+array,
				 nodepop, nodestart, classpop, tclasspop,
				 &nrnodes, ndsize, nbs,
				 mtry, mbs, mreplace,
				 nodeclass+array, ndbigtree, win, wr, wl, &nuse,
				 mperm, jstat, nbest, ndstart, ndend, wGini,
		         Vote, tnodewt
				 );
	
	/*
      Vote == 2: weighted voting
        tnodewt = average samples (class weighted) of each terminal node in current tree
        memset(tnodewt, 0, nrnodes*sizeof(tnodewt[0]));
	 */
	if(*Vote == 2){
	  memset(tw, 0, nrnodes*sizeof(tw[0]));
	  memset(tn, 0, nrnodes*sizeof(tn[0]));
	  bw_getweights(x, nsample, mdim, treemap+2*array, nodestatus+array,
					xbestsplit+array, bestvar+array, &nrnodes, ndbigtree,
					jin, win, tw, tn, tnodewt
					);
    }
	/*
	 Vote == 3: probability voting !!! Done in buildtree() function
	   tnodewt = probability of winning class of terminal node
		if(*Vote == 3){
		  bw_tnprop(nclass, nodestatus+array, nodeclass+array, classpop,
					ndbigtree, tnodewt
					);
	    }
	*/
	
    /* OUT-OF-BAG ESTIMATES */
    memset(jtr, 0, (*nsample)*sizeof(jtr[0]));
    memset(nodex, 0, (*nsample)*sizeof(nodex[0]));
    bw_testreebag(x, nsample, mdim, treemap+2*array,
				  nodestatus+array, xbestsplit+array, bestvar+array, nodeclass+array,
				  ndbigtree, jtr, nodex,
		          jin, dgini, minbgini, moobgini
				  );
	
    /* OOB sample prediction, depend on Vote (1:3) method */
    for(n=0; n < *nsample; n++){
      if(jin[n] == 0){
		counttr[n*(*nclass) + jtr[n]] += tnodewt[nodex[n]];
		out[n] += 1;
      }
    }
	
    /* ITEST; TESTSET prediction (different Vote method) */
    if(*itest > 0){
      bw_testreebag(xts, nts, mdim, treemap+2*array,
		            nodestatus+array, xbestsplit+array, bestvar+array, nodeclass+array,
					ndbigtree, jts, nodexts,
		            jints, dgini, minbginits, moobginits
					); /* gini increase not too much of use to us */
      for(n=0; n < *nts; n++){
		countts[n*(*nclass) + jts[n]] += tnodewt[nodexts[n]];
      }
    }
	
    /* IPROX; PROXIMITY */
    if(*iprox > 0){
      for(n=0; n < *nsample; n++){
        /* symmetric, using up-traiangular only */
		for(k=n; k < *nsample; k++){
          /* sample "n" & "k" land in the same terminal node */
		  if(nodex[k] == nodex[n]){
			prox[n*(*nsample) + k] += 1.0;
			if(k != n){
			  prox[k*(*nsample) + n] += 1.0;
			}
		  }
		}
      }
    }
	
	/*
     IIMP; VARIABLE IMPORTANCE
     Step: 1) locate those OOB samples in this tree
           2) for mvar in 1:mdim
                permute this feature mvar among those OOB samples
                predict these OOB use current tree, each sample will have a new prediction
               (if mvar not selected as split variable, permutation won't have effect)
           3) The difference between new prediction and old prediction will be used in importance measure
              calculation.
     For each feature, we'll have a permutation effects. Notice here that this is a ongoing step with the
       the tree growing process. So even for same feature, for different tree the permuation will
       be different. This is a big calculation.
	*/
    if(*iimp > 0){
	  memset(iv, 0, (*mdim)*sizeof(iv[0]));
      for(kt=0; kt < *ndbigtree; kt++){
		if(nodestatus[kt+array] != -1) iv[bestvar[kt+array]] = 1;
      }
	  /*
       selected as split variable: iv =1
       each node has only two possible status: 1 (internal, splitted), -1 (terminal)
	  */
	  
      for(mr=0; mr < *mdim; mr++){
		if(iv[mr] == 1){ /* selected as split variable */
		  bw_permobmr(&mr, x, tp, tx, jin, nsample, nperm, mdim, jvr);
		  /* possible improvement: only do those permuted oob samples */
		  bw_testreebag(x, nsample, mdim, treemap+2*array,
						nodestatus+array, xbestsplit+array, bestvar+array, nodeclass+array,
						ndbigtree, jvr, nodex,
						jin, dgini, minbginiimp, moobginiimp
						); /* potential use of gini increase for permuted samples ??????? */
		  for(n=0; n < *nsample; n++){
            /* out-of-bag sample */
			if(jin[n] == 0){
			  index = mr*(*nsample)*(*nclass) + n*(*nclass) + jvr[n];
			  countimp[index] += tnodewt[nodex[n]];
			}
		  }
		  /* possibility: only do those permuted oob samples */
		  for(n=0; n < *nsample; n++){
			x[n*(*mdim) + mr] = tx[n]; /* x being restored */
		  }
		}
      }
	  
      for(mr=0; mr < *mdim; mr++){
		/*
          not selected as split variable; permuting it has no effects in prediction
		  they have the same prediction as original one jtr[].
		*/
		if(iv[mr] == 0){
		  for(n=0; n < *nsample; n++){
 	 	    /* OOB sample */
			if(jin[n] == 0){
			  index = mr*(*nsample)*(*nclass) + n*(*nclass) + jtr[n];
			  countimp[index] += tnodewt[nodex[n]];
			}
		  }
		}
      }
	  
    }

    /* RUNNING OUTPUT: ERROR TRACING */
    if((*ilook > 0) & (fmod(jb+1, *nlook)==0)){
      Rprintf("%d trees: \n", jb+1);
      bw_comperrtr(counttr, ycl, nclass, nc, nsample, tmiss);
    }

  }
  
  /* calculate miss-classifications at the end of RF construction */
  Rprintf("%d trees: \n", jb);
  bw_comperrtr(counttr, ycl, nclass, nc, nsample, tmiss);
  
  /* NORMALIZE VOTES */
  for(n=0; n < *nsample; n++){
	pop = counttr[n*(*nclass)];
	for(i=1; i < *nclass; i++){
	  pop += counttr[n*(*nclass) + i];
	}
    for(i=0; i < *nclass; i++){
      counttr[n*(*nclass) + i] /= pop;
    }
  }
  
  /* FINISH IMPORTANCE MEASURE */
  if(*iimp > 0){
    bw_finishimp(ycl, counttr, nclass, nsample,
		         countimp, mdim, diffmarg, tmissimp
		         );
  }
  
  /* Free claimed memory */
  Free(mperm);
  Free(nperm);
  Free(jstat);
  Free(nbest);
  Free(ndstart);
  Free(ndend);
  Free(colList);
  Free(samplePos);
  Free(sampleValues);
  Free(dgini);
  Free(classpop);
  Free(win);
  Free(wl);
  Free(wr);
  Free(tclasspop);
  Free(tnodewt);
  if(*itest > 0){
	Free(minbginits);
	Free(moobginits);
  }
  if(*iimp > 0){
	Free(countimp);
	Free(tx);
	Free(tp);
	Free(minbginiimp);
	Free(moobginiimp);
  }
  if(*Vote == 2){
	Free(tw);
	Free(tn);
  }
  Free(nodepop);
  Free(jin);
  Free(nodex);
  Free(nodestart);
  Free(jtr);
  Free(mbs);
  Free(xbs);
  Free(ndbigtree);
  if(*itest > 0){
	Free(jts);
	Free(nodexts);
  }
  if(*iimp > 0){
	Free(iv);
	Free(jvr);
  }
  
  PutRNGstate();
  
}
