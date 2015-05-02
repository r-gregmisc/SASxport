"sample.genes.ind" <-
function( ngenes.ind , n, sd.ctrl, var.ratio, delta, distrn = "normal")
{ ## start of the fn sample.genes.ind
  ## note: here, delta is a number, can change it to a vector

  sample <- matrix(0, nr = ngenes.ind, nc = 2*n)
  sd.trt <- sqrt(var.ratio) * sd.ctrl

  sample[, 1:n] <- matrix(rnorm(n*ngenes.ind , rep(0,ngenes.ind), sd.ctrl), nr = ngenes.ind, nc = n)
  # get data for the the control group

  if(length(delta==1)) delta <- rep(delta, ngenes.ind)
  sample[, (n+1):(2*n)]<- matrix(rnorm(n*ngenes.ind , delta, sd.trt), nr = ngenes.ind, nc = n)
  # get data for the the treatment group, the diff from null group being the delta != 0

sample
} ## the end of the function sample.genes.ind
