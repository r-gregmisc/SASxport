% $Id$
%
\name{fit.contrast}
\alias{fit.contrast}
\alias{fit.contrast.lm}
\alias{fit.contrast.lme}
\alias{fit.contrast.mer}
\title{Compute and test arbitrary contrasts for regression objects}
\description{
 Compute and test arbitrary contrasts for regression objects.
}
\usage{
fit.contrast(model, varname, coeff, ... )
\method{fit.contrast}{lm}(model, varname, coeff, showall=FALSE,
             conf.int=NULL, df=FALSE, ...)
\method{fit.contrast}{lme}(model, varname, coeff, showall=FALSE,
             conf.int=NULL, df=FALSE, ...)
\method{fit.contrast}{mer}(model, varname, coeff, showall=FALSE,
             conf.int=NULL, sim.mer = TRUE, n.sim = 1000, ...)
}
\arguments{
  \item{model}{regression (lm,glm,aov,lme) object for which the
    contrast(s) will be computed.} 
  \item{varname}{variable name}
  \item{coeff}{vector or matrix specifying contrasts (one per row).}
  \item{showall}{return all regression coefficients. If \code{TRUE}, all
    model cofficients will be returned.  If \code{FALSE} (the default),
    only the coefficients corresponding to the specified contrast will
    be returned.}
  \item{conf.int}{numeric value on (0,1) or NULL.  If a numeric value is
    specified, confidence intervals with nominal coverage probability
    \code{conf.int} will be computed.  If \code{NULL}, confidence
    intervals will not be computed.}
  \item{df}{boolean indicating whether to return a column containing the
    degrees of freedom.}
  \item{\dots}{optional arguments provided by methods.}
  \item{sim.mer}{Logical value. If TRUE p-values and confidence
    intervals will be estimated using \code{mcmcsamp}. This option only takes effect for mer
    objects.}
  \item{n.sim}{Number of samples to use in \code{mcmcsamp}.}
  }
  
\details{
  Computes the specified contrast(s) by re-fitting the model with the
  appropriate arguments.  A contrast of the form \code{c(1,0,0,-1)}
  would compare the mean of the first group with the mean of the fourth group.
}
\value{
  Returns a matrix containing estimated coefficients, standard errors, t
  values, two-sided p-values. If \code{df} is TRUE, an additional column
  containing the degrees of freedom is included.  If \code{conf.int} is
  specified lower and upper confidence limits are also returned.}
\references{Venables & Ripley, Section 6.2}
  
\author{ Gregory R. Warnes \email{greg@warnes.net}}

\seealso{ \code{\link{lm}}, \code{\link{contrasts}},
  \code{\link{contr.treatment}},  \code{\link{contr.poly}},
  Computation and testing of General Linear Hypothesis:
  \code{\link{glh.test}}, Computation and testing of estimable functions
  of model coefficients: \code{\link{estimable}}, \code{\link{make.contrasts}}
  }

\examples{
y <- rnorm(100)
x <-  cut(rnorm(100, mean=y, sd=0.25),c(-4,-1.5,0,1.5,4))
reg <- lm(y ~ x)
summary(reg)

# look at the group means
gm <- sapply(split(y,x),mean)
gm


# mean of 1st group vs mean of 4th group
fit.contrast(reg, x, c(    1,    0,    0,   -1) )
# estimate should be equal to:
gm[1] - gm[4]

# mean of 1st and 2nd groups vs mean of 3rd and 4th groups
fit.contrast(reg, x, c( -1/2, -1/2,  1/2,  1/2) )
# estimate should be equal to:
sum(-1/2*gm[1], -1/2*gm[2], 1/2*gm[3], 1/2*gm[4])

# mean of 1st group vs mean of 2nd, 3rd and 4th groups
fit.contrast(reg, x, c( -3/3,  1/3,  1/3,  1/3) ) 
# estimate should be equal to:
sum(-3/3*gm[1], 1/3*gm[2], 1/3*gm[3], 1/3*gm[4])

# all at once
cmat <- rbind( "1 vs 4"    =c(-1, 0, 0, 1),
               "1+2 vs 3+4"=c(-1/2,-1/2, 1/2, 1/2),
               "1 vs 2+3+4"=c(-3/3, 1/3, 1/3, 1/3))
fit.contrast(reg,x,cmat)

#
x2 <- rnorm(100,mean=y,sd=0.5)
reg2 <- lm(y ~ x + x2 )
fit.contrast(reg2,x,c(-1,0,0,1))

#
# Example for Analysis of Variance
#

set.seed(03215)
Genotype <- sample(c("WT","KO"), 1000, replace=TRUE)
Time <- factor(sample(1:3, 1000, replace=TRUE))
y <- rnorm(1000)
data <- data.frame(y, Genotype, Time)


# Compute Contrasts & obtain 95\% confidence intervals

model <- aov( y ~ Genotype + Time + Genotype:Time, data=data )

fit.contrast( model, "Genotype", rbind("KO vs WT"=c(-1,1) ), conf=0.95 )

fit.contrast( model, "Time",
            rbind("1 vs 2"=c(-1,1,0),
                  "2 vs 3"=c(0,-1,1)
                  ),
            conf=0.95 )


cm.G <- rbind("KO vs WT"=c(-1,1) )
cm.T <- rbind("1 vs 2"=c(-1,1,0),
              "2 vs 3"=c(0,-1,1) )

# Compute contrasts and show SSQ decompositions

model <- aov( y ~ Genotype + Time + Genotype:Time, data=data,
              contrasts=list(Genotype=make.contrasts(cm.G),
                             Time=make.contrasts(cm.T) )
            )

summary(model, split=list( Genotype=list( "KO vs WT"=1 ),
                           Time = list( "1 vs 2" = 1,
                                        "2 vs 3" = 2 ) ) )


# example for lme 
library(nlme)
data(Orthodont)
fm1 <- lme(distance ~ Sex, data = Orthodont,random=~1|Subject) 

# Contrast for sex.  This example is equivalent to standard treatment
# contrast.
#
fit.contrast(fm1, "Sex", c(-1,1), conf.int=0.95 )
#
# and identical results can be obtained using lme built-in 'intervals'
#
intervals(fm1)

# Cut age into quantile groups & compute some contrasts
Orthodont$AgeGroup <- gtools::quantcut(Orthodont$age)
fm2 <- lme(distance ~ Sex + AgeGroup, data = Orthodont,random=~1|Subject)
#
fit.contrast(fm2, "AgeGroup", rbind("Linear"=c(-2,-1,1,2),
                                    "U-Shaped"=c(-1,1,1,-1),
                                    "Change-Point at 11"=c(-1,-1,1,1)),
                              conf.int=0.95)


}
\keyword{ models }
\keyword{ regression }

