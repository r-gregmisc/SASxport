## R wrapper functions to RFr1.c
RF <- function(ycl, x, classwt=NULL, Vote=2,
                 mtry=NULL, ntree=1000, ndsize=1, nbs=NULL, nreplace=TRUE, mreplace=FALSE,
                 itest=FALSE, xts=0, nts=1, jints=0,
                 nlook=0,
                 iprox=FALSE, iimp=FALSE, ikeepft=FALSE, wGini=TRUE
                 )
{
  ## parameter preparation
  mdim <- dim(x)[2]
  nsample <- dim(x)[1]
  nclass <- length( unique(ycl) )
  nc <- as.numeric( table(ycl) )
  mtry <- ifelse(is.null(mtry), sqrt(mdim), mtry)
  nbs <- ifelse(is.null(nbs), nsample, nbs)
  ilook <- ifelse(nlook<=0,FALSE, TRUE)
  if(is.null(classwt)){
    classwt <- rep(1/nclass, nclass)
  }
  else{
    classwt <- classwt/sum(classwt)
  }

  nrnodes = 2*(nsample/ndsize) + 1
  mimp = iimp*(mdim-1)+1
  nimp = iimp*(nsample-1)+1
  near = iprox*(nsample-1)+1
  Nkeep = ikeepft*(ntree-1)+1

  if(iimp){
    tmissimp <- matrix(double(nclass*mdim), nclass, mdim)
    diffmarg <- double(mdim)
  }
  else{
    tmissimp <- double(1)
    diffmarg <- double(1)
  }
      
  ## RF program running
  run.RF <- 
  .C("bw_RF",
   as.integer(ycl),
   as.integer(nclass),
   as.integer(nc),
   as.double(classwt),
   as.integer(Vote),
   as.double(t(x)),
   as.integer(mdim),
   as.integer(nsample),
   as.integer(mtry),
   as.integer(ntree),
   as.integer(ndsize),
   as.integer(nbs),
   as.integer(nreplace),
   as.integer(mreplace),
   as.integer(itest),
   as.double(xts),
   as.integer(nts),
   as.integer(jints),
   as.integer(ilook),
   as.integer(nlook),
   as.integer(iprox),
   as.integer(iimp),
   as.integer(ikeepft),
   counttr    = matrix(double(nclass*nsample), nclass, nsample),
   out        = integer(nsample),
   countts    = matrix(double(nclass*nts), nclass, nts),
   prox       = matrix(double(near^2), near, near),
   tmiss      = double(nclass),
   tmissimp   = tmissimp,
   diffmarg   = diffmarg,
   minbgini   = double(mdim),
   moobgini   = double(mdim),
   wGini      = as.integer(wGini),
   treemap    = array(  integer(2*nrnodes*Nkeep), dim=c(2,nrnodes,Nkeep) ),
   bestvar    = matrix( integer(nrnodes*Nkeep),   nrnodes, Nkeep ),
   xbestsplit = matrix( double(nrnodes*Nkeep),    nrnodes, Nkeep ),
   nodeclass  = matrix( integer(nrnodes*Nkeep),   nrnodes, Nkeep ),
   nodestatus = matrix( integer(nrnodes*Nkeep),   nrnodes, Nkeep ),
   DUP=FALSE
   #PACKAGE="bwRF"
   )
  a <- run.RF[24:38]
  class(a) <- "RF"
  a$call <- match.call()
  return(a)
  
}

########################################################
print.RF <- function(x, ...){
  cat("RF object\n");
  cat("---------\n");
  cat("\n")
  cat("call: ")
  print(x$call)
  cat("\n")
}
