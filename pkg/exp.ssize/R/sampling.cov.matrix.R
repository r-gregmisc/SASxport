"sampling.cov.matrix" <-
function (cov.matrix, ngenes)	
{
    pos.last <- ngenes
    pos.start <- ceiling(pos.last * runif(1,0,1))
    sample.cov <- cov.matrix[[pos.start]]

  sample.cov
}
