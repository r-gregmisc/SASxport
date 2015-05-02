\name{make.density}
\alias{make.density}
\title{Generate a function to compute an unnormalized density from a
  Bayesian model object.}
\description{
  Generate a function to compute an unnormalized density from a
  Bayesian model object.
}
\usage{
make.density(m, data)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{m}{Object of class 'model'.}
  \item{data}{Observed data for which the density will be computed.}
}
\details{
  This function translates a Bayesian model specification and
  corresponding observed data into a working R function which calculates
  the unnormalized density of the model for specified values of the parameter.
}
\value{
  An R function, which accepts a vector of parameter values and returns
  a log-likelihood.
}
\author{Gregory R. Warnes \email{warnes@bst.rochester.edu}}
%\seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }
\examples{


Example.Model <- model(
    Y = 1/Z, #Z = 1/Y  fixed relationships must be expressed with
             # parameters on the LHS and
             # observed values on the RHS
    Y ~ N(X%*%Beta,sigma.2),
    Beta ~ N(0,Beta.var.2),
    sigma.2 ~ InvGamma( V, 1)
    )
    # returns an object of class 'model'
    
X.data <- rnorm(10)
Y.data <- rnorm(X.data*2)  # hidden variable
Z.data <- 1/Y.data
    
Example.Data <- list(
    Beta.var.2 = 90,
    X = X.data,
    Z = Z.data,
    V = 10
    )

ldensity <- make.density(Example.Model, Example.Data)

# find the posterior mode
optim( par=c(rep(0,10),0.01),
       function(x) -ldensity(Beta=x[1:10], sigma.2=x[11])
     )
}
\keyword{models}
