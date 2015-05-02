"sample.alt.ind" <-
function( ngenes.alt.ind , n, sd.vector, var.ratio, delta)
				
{ ## start of the fn sample.alt.ind

  sd.ctrl <- sample(sd.vector, ngenes.alt.ind)
  
  delta <- sign(runif(ngenes.alt.ind, 0, 1) -0.5) * delta
  sample.res <- sample.genes.ind( ngenes.alt.ind , n, sd.ctrl, var.ratio, delta)

sample.res
} ## the end of the function sample.alt.ind
