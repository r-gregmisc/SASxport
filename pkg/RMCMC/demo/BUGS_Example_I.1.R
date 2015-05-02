
library(RMCMC)

Model <- model(
               ## likelihood
               Y ~ Normal( alpha  + beta * (x  - x.bar ),  sigma.c ),
               alpha ~ Normal( alpha.c , sigma.alpha ),
               beta  ~ Normal( beta.c , sigma.beta ),

               ## prior
               sigma.c = 1/sqrt(tau.c),
               sigma.alpha = 1/sqrt(alpha.tau),
               sigma.beta  = 1/sqrt(beta.tau),
               
               tau.c ~ Gamma(0.001,0.001),
               alpha.c ~ Normal(0.0,1.0E-6),
               alpha.tau ~ Gamma(0.001,0.001),
               beta.c ~ Normal(0.0,1.0E-6),
               beta.tau ~ Gamma(0.001,0.001),
               
               alpha0 = alpha.c - x.bar * beta.c
               )

Data <- list(
             x = c(8.0, 15.0, 22.0, 29.0, 36.0),
             x.bar = 22,
             Y = matrix(
               c(151, 199, 246, 283, 320,
                 145, 199, 249, 293, 354,
                 147, 214, 263, 312, 328,
                 155, 200, 237, 272, 297,
                 135, 188, 230, 280, 323,
                 159, 210, 252, 298, 331,
                 141, 189, 231, 275, 305,
                 159, 201, 248, 297, 338,
                 177, 236, 285, 350, 376,
                 134, 182, 220, 260, 296,
                 160, 208, 261, 313, 352,
                 143, 188, 220, 273, 314,
                 154, 200, 244, 289, 325,
                 171, 221, 270, 326, 358,
                 163, 216, 242, 281, 312,
                 160, 207, 248, 288, 324,
                 142, 187, 234, 280, 316,
                 156, 203, 243, 283, 317,
                 157, 212, 259, 307, 336,
                 152, 203, 246, 286, 321,
                 154, 205, 253, 298, 334,
                 139, 190, 225, 267, 302,
                 146, 191, 229, 272, 302,
                 157, 211, 250, 285, 323,
                 132, 185, 237, 286, 331,
                 160, 207, 257, 303, 345,
                 169, 216, 261, 295, 333,
                 157, 205, 248, 289, 316,
                 137, 180, 219, 258, 291,
                 153, 200, 244, 286, 324),
               nrow=30, ncol=5, byrow=TRUE)
             )

Initial.Values <- list(
                       alpha = rep(250, 30),
                       beta = rep(6,30),
                       alpha.c = 150,
                       beta.c = 10,
                       tau.c = 1,
                       alpha.tau = 1,
                       beta.tau = 1)
Initial.Vector <- unlist(Initial.Values)


ldensity <- make.density(Model, Data)


ldensity(Initial.Values)


# find posterior mode

peak <- optim( Initial.Vector,
  function(x) ldensity(unvector(x, template=Initial.Vector) )
  ,
  control=list(maxit=1e6, fnscale=-1),
  lower=0.01
  )

