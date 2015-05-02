## return a function that generates a Metropolis-Hastings MCMC sampler
## using the provided posterior and proposal.  Extra arguments will be
## appended to the call to the proposal.

mh <- function( posterior, qgenerator, qdensity, x0, ..., log=FALSE)
  {
    npar <- unlist(length(x0))
    # ensure everything works, so we show errors early on
    cat("Testing that the posterior density function works properly on x0...")
    posterior(unlist(x0))
    cat("Success.\n")

    cat("Testing that the proposal generator function works properly on x0...")
    qgenerator(unlist(x0))
    cat("Success.\n")

    cat("Testing that the proposal generator function works properly on x0...")
    qdensity(unlist(x0), unlist(x0))
    cat("Success.\n")

    constructor <- match.call()
    
    fun <- function(x0, niter)
      {
        ## test parameters
        if(niter <1) niter <- 0
        
        ## step 0: setup
           X <- matrix( NA, nrow=niter+1, ncol=npar ) # sampler state
           X[1,] <- unlist(x0)                        # initial state
           # note that X is 1 element longer than the number of iterations

           Y <- matrix( NA, nrow=niter+1, ncol=npar ) # proposed state

           p.X <- numeric(length=npar)  # p(X): posterior density at X
           p.Y <- numeric(length=npar)  # p(Y): posterior density at Y

           q.Y.X <- numeric(length=npar) # q(X,Y):proposal density from X to Y 
           q.X.Y <- numeric(length=npar) # q(Y,X):proposal density from Y to X

           alpha <- numeric(length=npar) # alpha(X,Y): trans. prob form X to Y


        for(t in 1:niter+1)
          {
            ## step 1: generate Y
            Y[t] <- proposal(X[t], ...)

            ## step 2: calculate transition probability
            if(log)
              {
                p.X[t] <- posterior(X[t], log=TRUE)
                p.Y[t] <- posterior(Y[t], log=TRUE)
            
                q.X.Y[y] <- qdensity( X[t], Y[t], log=TRUE)
                q.Y.X[y] <- qdensity( Y[t], X[t], log=TRUE)

                alpha <- max(1, exp(p.X[t] - p.Y[t] + q.Y.X[t] - q.X.Y[t]))
              }
            else
              {
                p.X[t] <- posterior(X[t])
                p.Y[t] <- posterior(Y[t])
            
                q.X.Y[t] <- qdensity( X[t], Y[t])
                q.Y.X[t] <- qdensity( Y[t], X[t])

                alpha[t] <- max(1, p.X[t] / p.Y[t] * q.Y.X[t] / q.X.Y[t])
              }

            ## step 3: flip a coin to decide whether X_t or Y is the next state
            u <- runif()
            if( u < alpha[t] )
              X[t+1] <- Y
            else
              X[t+1] <- X[t]
          }
              
        retval <- list(
                       niter=niter,
                       X = X,
                       Y = Y,
                       p.X = p.X,
                       p.Y = p.Y,
                       q.Y.X = q.Y.X,
                       q.X.Y = q.X.Y,
                       alpha = alpha,
                       call = match.call(),
                       constructor=constructor,
                       ) 
        
        
      }

    
  }
