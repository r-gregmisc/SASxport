"sample.alt.dep" <-
function( ngenes.alt.dep , n, var.ratio, cov.matrix, ngenes.matrix, delta, distrn = "normal")
{ ## start of the fn sample.null.dep

     sample <- sample.dep(ngenes.alt.dep , n,  var.ratio, cov.matrix, ngenes.matrix, delta )
     sample

} ## the end of the function sample.null.dep
