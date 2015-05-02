"sample.null.dep" <-
function( ngenes.null.dep , n, var.ratio, cov.matrix, ngenes.matrix,
         distrn = "normal")
{ ## start of the fn sample.null.dep
  
     sample <- sample.dep(ngenes.null.dep , n, var.ratio,
                          cov.matrix, ngenes.matrix, delta = 0)

     sample

} ## the end of the function sample.null.dep
