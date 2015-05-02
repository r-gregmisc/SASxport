# This function creates a matrix containing all combinations of the
# vectors passesd as arguments.  It can be used to generate the
# treatment levels of a full factorial design from a list of levels
# for each treatment factor.

factorial.design <- function( ... )
  {
    factors <- list(...)
    design <- matrix(factors[[1]],nrow=length(factors[[1]]), ncol=1)
    factors[[1]] <- NULL
    for(factor in factors)
      {
        reps <- length(factor)
        template <- design
        for( i in 2:reps ) template <- rbind(template, design)
        design <- cbind(template, rep(factor, length=nrow(template)))
      }
    design
  }
