% $Id$
%
\name{make.contrasts}
\alias{make.contrasts}
\title{Construct a User-Specified Contrast Matrix}
\description{
  Construct a user-specified contrast matrix.
}
\usage{
make.contrasts(contr, how.many = ncol(contr))
}
\arguments{
  \item{contr}{ vector or matrix specifying contrasts (one per row).}
  \item{how.many}{ dimensions of the desired contrast matrix.  This
    must equal the number of levels of the target factor variable.}
  }
\details{
  This function converts human-readable contrasts into the form that R
  requires for computation.

  Specifying a contrast row of the form
  \code{c(1,0,0,-1)} creates a contrast that will compare the mean of the
  first group with the mean of the fourth group.
}
\value{
  \code{make.contrasts} returns a matrix with dimensions
  (\code{how.many}, \code{how.many}) containing the specified contrasts
  augmented (if necessary) with orthogonal "filler" contrasts.

  This matrix can then be used as the argument to
  \code{\link{contrasts}} or to the \code{contrasts} argument of model
  functions (eg, \code{\link{lm}}).
}
\author{ Gregory R. Warnes \email{greg@warnes.net}}
\seealso{ \code{\link{lm}}, \code{\link{contrasts}},
  \code{\link{contr.treatment}},  \code{\link{contr.poly}},
  Computation and testing of General Linear Hypothesis:
  \code{\link{glh.test}}, Computation and testing of estimable functions
  of model coefficients: \code{\link{estimable}}, Estimate and Test
  Contrasts for a previously fit linear model: \code{\link{fit.contrast}}
  }

  \examples{
set.seed(4684)
y <- rnorm(100)
x.true <- rnorm(100, mean=y, sd=0.25)
x <-  factor(cut(x.true,c(-4,-1.5,0,1.5,4)))
reg <- lm(y ~ x)
summary(reg)

# Mirror default treatment contrasts
test <- make.contrasts(rbind( c(-1,1,0,0), c(-1,0,1,0), c(-1,0,0,1) ))
lm( y ~ x, contrasts=list(x = test ))

# Specify some more complicated contrasts
#   - mean of 1st group vs mean of 4th group
#   - mean of 1st and 2nd groups vs mean of 3rd and 4th groups
#   - mean of 1st group vs mean of 2nd, 3rd and 4th groups
cmat <- rbind( "1 vs 4"    =c(-1, 0, 0, 1),
               "1+2 vs 3+4"=c(-1/2,-1/2, 1/2, 1/2),
               "1 vs 2+3+4"=c(-3/3, 1/3, 1/3, 1/3))

summary(lm( y ~ x, contrasts=list(x=make.contrasts(cmat) )))
# or
contrasts(x) <- make.contrasts(cmat)
summary(lm( y ~ x ) )

# or use contrasts.lm
reg <- lm(y ~ x)
fit.contrast( reg, "x", cmat )

# compare with values computed directly using group means
gm <- sapply(split(y,x),mean)
gm %*% t(cmat)


#
# Example for Analysis of Variance
#

set.seed(03215)
Genotype <- sample(c("WT","KO"), 1000, replace=TRUE)
Time <- factor(sample(1:3, 1000, replace=TRUE))
data <- data.frame(y, Genotype, Time)
y <- rnorm(1000)

data <- data.frame(y, Genotype, as.factor(Time))

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

model <- model <- aov( y ~ Genotype + Time + Genotype:Time, data=data,
                      contrasts=list(Genotype=make.contrasts(cm.G),
                                     Time=make.contrasts(cm.T) )
                      )

summary(model, split=list( Genotype=list( "KO vs WT"=1 ),
                           Time = list( "1 vs 2" = 1,
                                        "2 vs 3" = 2 ) ) )


}
\keyword{ models }
\keyword{ regression }
