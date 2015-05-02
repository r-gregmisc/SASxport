# file to run sample size simulation through PVM

## step 1: start and config PVM

#
# step 2a: load packages for pvm 
# 
library(rpvm)
library(snow)

# functions from Greg
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
DEBUG=TRUE

exitfun <- function()
  {
    traceback()
    scat("ERROR, Stopping PVM cluster ")
    stopCluster(cl)
    scat("Done.")
  }
on.exit( exitfun, add=TRUE )

scat <- function(...)
  {
    if(DEBUG)
      {
        cat("### ", file=stderr())
        cat(..., file=stderr())
        cat(" ###\n", file=stderr())
        flush(stderr())
      }
    NULL
  }

# export data from current frame to nodes of cluster
clusterExport <- function (cl, list, pos=-1)
{
    for (name in list) {
        clusterCall(cl,
                    function(n, v) assign(n, v, env = .GlobalEnv), 
                    name,
                    get(name, envir=sys.frame(sys.parent()))
                    )
    }
}

# export data from current frame to nodes of cluster via shared fs
clusterFSExport <- function (cl, list, envir=parent.frame(), path)
{
  fname <- paste(".clusterFSExport",Sys.getpid(),"Rda",sep=".")
  fname <- file.path(path,fname)
  scat("Saving data to ", fname, "")
  save(list=list, file=fname, envir=envir)
  scat("Done.")
  
  scat("Asking all nodes to load data from ", fname, "")
  clusterExport(cl, "fname")
  clusterCall(cl, function(x) load(fname, envir=.GlobalEnv) )
  scat("Done.")  
}
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#
# step 2b: set initial paramters and load data and functions
# 

ncpu <- 20; # gsun574 can take up to 20 cpu's
scat("Starting PVM cluster with", ncpu, "nodes \n")
cl <- makePVMcluster(ncpu)
scat("Done. \n")

load("/home/liup01/Peng/sd.vector.Rdata")
load("/home/liup01/Peng/cov.list50.all.Rdata")
source("/home/liup01/Peng/ssize.parameter574.nonull.R")
source("/home/liup01/Peng/get.plot.comparison.R")

scat("Initialize the cluster element with libraries and data sets. \n")

# make data available on all nodes
clusterFSExport(cl, c("sd.vector", "cov.list", "ssize.parameter574.nonull", "get.plot.comparison"),
                path="/home/liup01" )

# make libraries available on all nodes
setup <- function()
{
   library(MASS)
   library(exp.ssize, lib.loc="/home/liup01/Peng/Rlib")
}
clusterCall(cl, setup)

if(exists("last.warning"))
   warnings()
cat("Done.")

#
# step 3: provide paramters to check for functions
#

# function to get combinations of different levels
# DO NOT add factors that only have one level here
# add them next by using rep

 factorial.design <- function( ... )
  {
    factors <- list(...)
    design <- matrix(factors[[1]],nrow=length(factors[[1]]), ncol=1)
    factors[[1]] <- NULL
    for(factor in factors)
      {
        reps <- length(factor)
        template <- design
        for( i in 2:reps ) template <- rbind(template, design)
        design <- cbind(template, rep(factor, length=nrow(template)))
      }
    design
  }

 ngenes <- 10000;
 nsample.simu <- 985;
 fractn.alt <- c(1, 0.5, 0.1, 0.05)
 fractn.dep <- 0
 # fractn.dep <- c(1,0.8,0.5,0)
 var.ratio <- c(1, 3, 10)
 delta <- 2;

 # temp <- factorial.design(fractn.alt, fractn.dep, var.ratio)
 temp <- factorial.design(fractn.alt, var.ratio)
 nr <- dim(temp)[1]
 emat <- cbind(rep(ngenes, nr), rep(nsample.simu, nr), temp[,1],
               rep(fractn.dep,nr), temp[,2] , rep(delta, nr))
 
 myssize <- function(vec)
  {
    ngenes <- vec[1]
    nsample.simu <- vec[2]
    fractn.alt <- vec[3]
    fractn.dep <- vec[4]
    var.ratio <- vec[5]
    delta <- vec[6]
    pdf(file = paste("/home/liup01/Peng/result/985Sample/28th/PowSsizePlot",paste(vec,collapse="_"),".pdf"))
    res <- ssize.parameter574.nonull(ngenes, nsample.simu, 
                fractn.alt, fractn.dep, var.ratio, delta)

    dev.off()
    res
  }

#
# step 4: distribute work across the cluster
#

parRapply <- function(cl, x, fun, join.method = cbind, ...)
  docall(join.method, clusterApplyLB(cl,
				     splitRows(x, length(cl)*10),
				     apply, 1, fun, ...))

cat("Starting paralle simulation and computation with", ncpu, "nodes \n")

#
# step 5: run
#
time <- system.time(
		    fits <- parRapply(cl, emat, myssize)
		    )
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# output format
#
# fits is a list of result(refer to with res) for each set of parameters
#      res is a list of $power.est and $pow.real
#          power.est is a list of result(est.res) for each size of n.est
#                est.res is a list of $calc.power and $propn.80
#          power.real is a list of $true.power and $true.propn.80
#  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

save(fits, emat, file = "/home/liup01/Peng/result/985Sample/28th/fits.emat574.Rdata")
rm(cov.list, sd.vector)
cat("Done. Computation used", time, " \n")

if(exists("last.warning"))
  warnings()

#
# step 6: stop cluster
#

cat("Stop the cluster. \n")
stopCluster(cl)
on.exit(NULL)
cat("Done. \n")
