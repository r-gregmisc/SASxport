"sampling.cov.matrix.2" <-
function (cov.list,ngenes.dep)	
{   # ngenes.dep needs to be positive integer

    nlist <- length(cov.list)
    ndep <- 50;		# dimension of each covariance matrix in the list

    ngrp <- ngenes.dep %/% ndep;  # number of groups of size 50
    remainder <- ngenes.dep - ngrp * 50
    if (remainder == 0) {
    cov.list.selected <- cov.list[sample(1:nlist, ngrp)]
    } else
    { cov.list.selected <- cov.list[sample(1:nlist, ngrp+1)]
      cov.list.selected[[ngrp + 1]]  <-  cov.list.selected[[ngrp + 1]][1:remainder, 1:remainder]
    } # end of if
    
  cov.list.selected
}
