"sample.genes.dep" <-
function(n, delta, cov.ctrl, var.ratio)
{
     ndep <- ifelse(length(cov.ctrl) != 1, length(cov.ctrl[1,]), 1)	
   #  # get num(genes)/dependent group if the covariance matrices have different dim

     temp.sample <- matrix(0, nr = ndep, nc = 2*n)		# place to hold the sample generated

     temp.sample[,1:n] <- t(mvrnorm(n, rep(0, ndep), cov.ctrl))	# get the sample for control
								# dim: row: different genes
								#      col: n (sample size)

     cov.trt <- var.ratio * cov.ctrl				# get covariance for treatment
     delta <- sign(runif(ndep, 0, 1) -0.5) * delta
     temp.sample[,(n+1):(2*n)] <- t(mvrnorm(n, delta, cov.trt))	# get sample for treatment

     temp.sample
}
