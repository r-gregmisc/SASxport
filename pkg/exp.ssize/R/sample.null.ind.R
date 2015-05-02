"sample.null.ind" <-
function( ngenes.null.ind , n, sd.vector, var.ratio)
{
   sd.ctrl <- sample(sd.vector, ngenes.null.ind)

   sample.res <- sample.genes.ind(ngenes.null.ind , n, sd.ctrl, var.ratio, delta = 0)

   sample.res
} ## the end of the function sample.null.ind
