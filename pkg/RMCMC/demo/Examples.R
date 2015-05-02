
#######
# Sample abstract Model
#######

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
    )

######
# Sample concrete Model
######

Example.Model <- model(
    Y = 1/Z,  #Z = 1/Y,  fixed relationships must be expressed with
             # parameters on the LHS and
             # observed values on the RHS
    Y ~ N(X%*%Beta,sigma.2),
    Beta ~ N(0,Beta.var.2),
    sigma.2 ~ InvGamma( V, 1),

    data = list(
                Beta.var.2 = 90,
                V = 30,
                X = X.data,
                Z = Z.data,
                )
    )

#########
# Example Concrete Model with Blocking
#########

# Block on the beta
Example.Model <- model(
    Y = 1/Z,  #Z = 1/Y,  fixed relationships must be expressed with
             # parameters on the LHS and
             # observed values on the RHS
    Y ~ N(X%*%Beta,sigma.2)
    Beta ~ MvN(rep(0,30),diag(Beta.var.2,30))
    sigma.2 ~ invGamma( V, 1),

    data = list(
                Beta.var.2 = 90
                V = 30
                X = X.data
                Z = Z.data
                )
    )


# Block on several parameters that are not part of the same distribution
Example.Model <- model(
    Y = 1/Z,  #Z = 1/Y,  fixed relationships must be expressed with
             # parameters on the LHS and
             # observed values on the RHS
    Y ~ MvN(X%*%Beta,diag(sigma.2,30))
    Beta[ 1:10] ~ NvN(0,diag(Beta.var.2,10))
    Beta[11:30] ~ MvN(0,diag(Beta.var.2,20))
    sigma.2 ~ InvGamma( V, 1),
    
    data = list(
                Beta.var.2 = 90
                V = 30
                X = X.data
                Z = Z.data
                )
    )

# Block on sigma & beta
Example.Model <- model(
    Y = 1/Z,  #Z = 1/Y,  fixed relationships must be expressed with
             # parameters on the LHS and
             # observed values on the RHS
    Y ~ N(X%*%Beta,sigma.2)
    Beta ~ MvN(rep(0,30),diag(Beta.var.2,30))
    sigma.2 ~ invGamma( V, 1)

    <all other variables>
    
    data = list(
                Beta.var.2 = 90
                V = 30
                X = X.data
                Z = Z.data
                )
    )


#########
# Example proposal
#########

Proposal.Model <- model(
    Beta <- N(Beta,30),
    sigma.2 <- InvGamma( 25, 1)
)

# -->  proposalGenerator <- function(Beta,sigma^2) 
#      { 
#          Beta.new <- rnorm(Beta,30)
#          sigma.2.mew <- rInvGamma( 25, 1)
#          return( list(Beta=Beta.new,
#                        sigma.2=sigma.2.new)
#                 )
#      }
#
# -->  proposalDensity <- function(Beta,sigma.2) 
#      { 
#          Beta.logLik <- log(dnorm(Beta,30))
#          sigma.2.logLik <- dInvGamma( sigma.2, 25, 1)
#          return( sum(Beta.loglik, sigma.2.loglik)
#      }
#

# For the last example of blocking
# -->  proposalGenerator <- list(
#          f1 <- function(Beta, sigma.2, <all other parameters>)
#               { 
#                   Beta.new <- rnorm(Beta,30)
#                   sigma.2.mew <- rInvGamma( 25, 1)
#                   return( list(Beta=Beta.new,
#                                sigma.2=sigma.2.new) )
#               }
#           f2 <- function(Beta, sigma.2, <all other parameters>)
#               {
#                   <...>
#               }
#      )

########
# Example Sampler 
########

    
# Convert model code + data into R functions
makeDensity.model <- function(model, data)
{
    # returns a function for <logDensity> = fun(current=<current state>)
    #   <OR> a set of functions, one for each model parameter 
    # parse model into 'tree'
    # manipulate tree
    # convert tree to output
    density.function <- function(current.state) {}
    density.function

    
}

# For Gibb Sampler

MakeGibbsProposal.model <- function(model)
{
    # returns a function for <new state> = fun(current=<current state>)
}

# For Metropolis Proposal


# Covert proposal model to functions

MakeProposalGenrator <- function(model, data)
{
    # returns a function for <new state> = fun(current=<current state>)
}

MakeProposalDensity <- function(model, data)
{
    # returns a function for <logDensity> = fun(current=<current state>, proposed=<proposaed state>)
}



