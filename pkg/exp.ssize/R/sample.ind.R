"sample.ind" <-
function( ngenes.ind , n, sd.ctrl, var.ratio, delta)
{ ## start of the fn sample.null.ind
  ## note: here, delta is a number, can change it to a vector

  sd.trt <- sqrt(var.ratio) * sd.ctrl

  sample.ctrl <- matrix(rnorm(n*ngenes.ind , rep(0,ngenes.ind), sd.ctrl), nr = ngenes.ind, nc = n)
  # get data for the the control group

  if(length(delta==1)) delta <- rep(delta, ngenes.ind)
  sample.trt <- matrix(rnorm(n*ngenes.ind , delta, sd.trt), nr = ngenes.ind, nc = n)
  # get data for the the treatment group, the diff from null group being the delta != 0

  sample <- cbind(sample.ctrl, sample.trt)
  ## pooling them together by setting the first n columns are from ctrl for each gene

sample
} ## the end of the function sample.null.ind
