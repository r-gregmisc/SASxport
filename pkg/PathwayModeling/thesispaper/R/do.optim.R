"do.optim" <-
function(start=runif(9,1,100),scail=rep(1,9)) {
optim(start,paperSSQ,method="L-BFGS-B",lower=0.00001,upper=50000,control=list(maxit=10000,parscale=scail))
}

