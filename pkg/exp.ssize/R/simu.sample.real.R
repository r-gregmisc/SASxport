"simu.sample.real" <-
function(sd.null, sd.alt, cov.null, ngenes.null.dep, cov.alt, ngenes.alt.dep, n,
		var.ratio, delta)

{ ## start of the function simu.sample.real

  ngenes.null.ind <- length(sd.null)
  ngenes.alt.ind <- length(sd.alt)
  ngenes <- sum(ngenes.null.ind, ngenes.null.dep, ngenes.alt.ind, ngenes.alt.dep)

  result<- matrix(0, nr = ngenes, nc = n*2)	# place to store the simulated sample

# simulate sample for the each category

if (ngenes.null.ind > 0 ) {
  index <- c(1, ngenes.null.ind)
  result[index[1] : index[2], ] <- sample.genes.ind.2( n , sd.null, var.ratio, delta = 0)

 }
 
if (ngenes.null.dep > 0) {
  index <- ngenes.null.ind + c(1, ngenes.null.dep)
  result[index[1] : index[2], ] <- sample.dep.2(ngenes.null.dep , n, var.ratio, cov.null, delta = 0)
 }

if (ngenes.alt.ind > 0) {
  index <- ngenes.null.ind + ngenes.null.dep  + c(1, ngenes.alt.ind)
  result[index[1] : index[2], ] <- sample.genes.ind.2( n, sd.alt, var.ratio, delta)
}

if (ngenes.alt.dep > 0) {
  index <- ngenes.null.ind + ngenes.null.dep + ngenes.alt.ind + c(1, ngenes.alt.dep)
  result[index[1] : index[2], ] <- sample.dep.2(ngenes.alt.dep , n,  var.ratio, cov.alt, delta )
}	

 result 
} ## the end of the function simu.sample.real
