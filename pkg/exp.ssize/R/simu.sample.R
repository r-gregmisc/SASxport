"simu.sample" <-
function(ngenes, n, fractn.alt, fractn.dep, var.ratio, cov.matrix, ngenes.matrix, delta)
{ ## start of the function simu.sample

# get the number of genes in each of the four categories
  ngenes.null.ind <- round(ngenes * ( 1-fractn.alt ) * ( 1-fractn.dep ))
  ngenes.null.dep <- round(ngenes * ( 1-fractn.alt ) * fractn.dep )

  ngenes.alt.ind <- round(ngenes * fractn.alt * ( 1-fractn.dep ))
  ngenes.alt.dep <- ngenes - ngenes.null.ind - ngenes.null.dep - ngenes.alt.ind  

  result<- array(0, c(ngenes, n*2))	# place to store the simulated sample
					# for each gene, first n samples from ctrl
					# then n samples from treatment group


# simulate sample for the each category

if (ngenes.null.ind > 0 ) {
  index <- c(1, ngenes.null.ind)
  result[index[1] : index[2], ] <- sample.null.ind( ngenes.null.ind , n, sd.vector, var.ratio)
 }
 
if (ngenes.null.dep > 0) {
  index <- ngenes.null.ind + c(1, ngenes.null.dep)
  result[index[1] : index[2], ] <-   sample.dep(ngenes.null.dep , n, var.ratio, cov.matrix, ngenes.matrix, delta = 0)
 }

if (ngenes.alt.ind > 0) {
  index <- ngenes.null.ind + ngenes.null.dep  + c(1, ngenes.alt.ind)
  result[index[1] : index[2], ] <- sample.alt.ind( ngenes.alt.ind , n, sd.vector, var.ratio, delta)
}

if (ngenes.alt.dep > 0) {
  index <- ngenes.null.ind + ngenes.null.dep + ngenes.alt.ind + c(1, ngenes.alt.dep)
  result[index[1] : index[2], ] <- sample.dep(ngenes.alt.dep , n,  var.ratio, cov.matrix, ngenes.matrix, delta )
}	

 result[1:ngenes,]
} ## the end of the function simu.sample
