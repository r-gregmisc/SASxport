# ssize.parameter574.nonull.R
# perform the comparison of ssize estimation for a set of parameters

ssize.parameter574.nonull <- 
                function(ngenes, nsample.simu, 
                fractn.alt, fractn.dep, var.ratio, delta)
{
################
#   set all parameters that is default
################

  nrep.est <- c(5,15,30); nrep.simu <- c(3,4,5,6,8,10,12,15,20,40);
  sig.level <- 0.05; # fold.change = 2;

  n.cov.list <- length(cov.list);	

################
#   get the numbers to simulate in each group
################

  ngenes.null.ind <- round(ngenes * ( 1-fractn.alt ) * ( 1-fractn.dep ))
  ngenes.null.dep <- round(ngenes * ( 1-fractn.alt ) * fractn.dep )
  ngenes.null <- ngenes.null.ind + ngenes.null.dep

  ngenes.alt.ind <- round(ngenes * fractn.alt * ( 1-fractn.dep ))
  ngenes.alt.dep <- ngenes - ngenes.null.ind - ngenes.null.dep - ngenes.alt.ind  

################
#   get the sd/cov for each group
################

  sd.null <- sample(sd.vector, ngenes.null.ind, replace = TRUE)
  sd.alt <- sample(sd.vector, ngenes.alt.ind, replace = TRUE)

  cov.null <- cov.alt <- NULL;
  if (ngenes.null.dep > 0)  cov.null<- sampling.cov.matrix.2(cov.list,ngenes.null.dep)
  if (ngenes.alt.dep > 0)  cov.alt <- sampling.cov.matrix.2(cov.list,ngenes.alt.dep)

################
#   sample to est sd
################

  sample.est <- simu.sample.est(sd.null, sd.alt, cov.null, ngenes.null.dep, 
			cov.alt, ngenes.alt.dep, n.est=max(nrep.est))
  # generate sample of size [ngenes x max(nrep.est)] 

  est.sd <- est.sd.ctrl(sample.ctrl = sample.est, nrep = nrep.est)
  # output is matrix of sd with dim [ngenes x length(nrep.est)]
  rm(sample.est)

  power.est <- list.power.est(est.sd, ngenes.null=0, nrep.simu, delta, sig.level)
  names(power.est) <- as.character(nrep.est)
  # output is a list with the same length as nrep.est
  # each element of the list consists a list of two results for 
  # a set of sd based on corresponding nrep.est
  # the two results are: power.est[[i]]]$calc.power and $propn.80
  
################
#   sample to do t test and get simulated power
################

new.pool.res <- matrix(0,nr = ngenes, nc = max(nrep.simu) -1 )
# there are max(nrep.simu)-1 tests since no test for sszie = 1

  for ( i in 1:nsample.simu) 
    {
     n=max(nrep.simu)
     temp.sample <- simu.sample.real(sd.null, sd.alt, cov.null, 
		ngenes.null.dep, cov.alt, ngenes.alt.dep, n,
		var.ratio, delta)

     tp <- ttest.matrix(temp.sample[,1:n], temp.sample[,(n+1):(2*n)])
    # test.res <- tdecision.Bonf(tp, sig.level)
     test.res <- tdecision.FDR(tp, sig.level)
     old.pool.res <- new.pool.res
     new.pool.res <- old.pool.res + test.res
    }
   rm(temp.sample)

   avg.power <- new.pool.res / nsample.simu
   if (ngenes.null > 0) {
   cat("Observations coming from Ho group are used to estimate FDR")
   FDR.real <- apply(avg.power[1:ngenes.null,],2,mean)[(nrep.simu - 1)]
   # needs double check for how to est FDR
   names(FDR.real) <- as.character(nrep.simu)
   }

   power.real <- power.simu(avg.power, nrep.simu, ngenes.null)
   names(power.real) <- c("true.power", "true.propn.80")
   # the result is a list with 2 element:
   # $true.power, $true.propn.80
   rm(avg.power)

################
#   camparison of the result
################

  evec <-c(
           ngenes=ngenes,
           nsample.simu=nsample.simu,
           fractn.alt=fractn.alt,
           fractn.dep=fractn.dep,
           var.ratio=var.ratio,
           delta=delta,
           sig.level=sig.level
           )
  propn.real <- power.real$true.propn.80
  propn.est <- list()
  propn.est[[1]] <- power.est[[1]]$propn.80
  propn.est[[2]] <- power.est[[2]]$propn.80
  propn.est[[3]] <- power.est[[3]]$propn.80

  get.plot.comparison(nrep.simu, propn.real, propn.est ,evec)
  
  power.comp <- list(power.est, power.real)
  rm(power.est, power.real)
  names(power.comp) <- c("power.est", "power.real")
  power.comp
  list(power.comp = power.comp, est.sd = est.sd, FDR.real=FDR.real)
}
