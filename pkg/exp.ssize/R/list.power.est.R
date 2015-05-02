"list.power.est" <-
function(est.sd, ngenes.null, nrep.simu, delta, sig.level)

{
 ngenes <- dim(est.sd)[1]
 nsd <- dim(est.sd)[2]
 
 list.power.est <- list(nsd, names = colnames(est.sd))
 
 for ( i in 1: nsd)
 {
 list.power.est[[i]] <- calc.power.est(est.sd[(ngenes.null+1):ngenes,i],
 nrep.simu, delta, sig.level)
 }
 # only calculate power for genes from Ha

 list.power.est
 # output is a list with the same length as nrep.est
 # each element of the list consists of results for 
 # each set of sd based on corresponding nrep.est

}
