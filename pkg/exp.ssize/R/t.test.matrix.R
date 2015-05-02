"t.test.matrix" <-
function(ctr, trt)

{ ngenes <- dim(ctr)[1]
  ctr.s <- get.cumsum(ctr)
  trt.s <- get.cumsum(trt)

  ctr.m <- ctr.s/col(ctr.s) # mean ctr exprs for each gene
  trt.m <- trt.s/col(trt.s)

  diff <- ctr.m - trt.m

  ctr.ss <- get.cumsum(ctr^2) # get sum(Xi ^2)
  trt.ss <- get.cumsum(trt^2)

  ctr.ms <- (ctr.m)^2
  trt.ms <- (trt.m)^2
  ss.pool <- ctr.ss - col(ctr.ms) * ctr.ms + trt.ss - col(trt.ms) * trt.ms
  var.pool <- (ss.pool)/(col(ctr.ms) + col(trt.ms) - 2 )

  se.pool <- sqrt(var.pool * (1/col(ctr.ms) + 1/col(trt.ms) ))

# using the formula se = sqrt((sd.p)^2 * (1/n1 + 1/n2))
# where sd.p = ( sum(x - mean(x))^2 + sum(y - mean(y))^2 )/(n1 + n2 -2)
# 	  sum(x - mean(x))^2 = sum(x.^2) - n1 * (mean(x))^2

# pooled sd for equal sample size for both group
  
  ts <- diff/se.pool
  df <- col(ctr) + col(trt) - 2

# get rid of those null columns (for n =1)
  df<- matrix(df[!is.na(ts)], nr = ngenes)
  ts<- matrix(ts[!is.na(ts)], nr = ngenes)

  tp <- matrix(2*pt(-abs(c(ts)),df =c(df)), nrow = nrow(ts), nc = ncol(ts))
# multiplication factor 2: for 2-sided test p-values

tp
# output is a matrix of p-values of 2-sided t-test with dim
# ngenes x [ncol(ctr)-1]

}
