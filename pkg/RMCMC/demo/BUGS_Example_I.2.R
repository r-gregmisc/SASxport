
Model <- model(
               # likelihood
               x ~ Poisson( theta * t),

               # prior
               theta ~ Gamma(alpha, beta),

               # hyper-prior
               alpha ~ Exponential(1.0),
               beta ~ Gamma(0.1, 0.1)
             )


Data <- list(
             t = c(94.3, 15.7, 62.9, 126, 5.24, 31.4, 1.05, 1.05, 2.1, 10.5),
             x = c( 5, 1, 5, 14, 3, 19, 1, 1, 4, 22)
             )

Initial.Values <- list(
                       alpha = 1,
                       beta = 1,
                       theta = rep(1, 10)
                       )

Initial.Vector <- unlist(Initial.Values)

ldensity <- make.density(Model, Data)

peak = optim( Initial.Vector,
  function(x) ldensity(unvector(x, template=Initial.Vector) )
  ,
  control=list(maxit=1e6, fnscale=-1),
  lower=0.01
  )
