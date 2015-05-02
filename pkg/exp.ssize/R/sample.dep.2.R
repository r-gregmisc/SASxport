"sample.dep.2" <-
function( ngenes.dep , n, var.ratio, cov.matrix, delta, distrn = "normal")
{ ## start of the fn sample.dep.2
  ## cov.matrix is a list of cov matrices, not NULL

  sum.genes <- 0;
  sample.res <- matrix(0, nr = ngenes.dep, nc = 2*n)

  for ( i in 1:length(cov.matrix))
    {
     temp.sample <- sample.genes.dep(n, delta, cov.matrix[[i]], var.ratio )
     ndep <- dim(temp.sample)[1]
     sample.res[(sum.genes+1) : (sum.genes+ndep), ] <- temp.sample

     sum.genes <- ndep + sum.genes		# update the sum
    }  # end of for

sample.res

} ## the end of the function sample.dep.2
