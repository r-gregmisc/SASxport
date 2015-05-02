% $Id$
%
\name{estimable}
\alias{estimable}
\alias{estimable.default}
\alias{estimable.mer}
\alias{estimable.mlm}
%\alias{.wald}
%\alias{.to.est}
\title{Contrasts and estimable linear functions of model coefficients}
\description{
  Compute and test contrasts and other estimable linear
  functions of model coefficients for for lm, glm, lme, mer, and geese
  objects
}
\usage{
estimable(obj, cm, beta0, conf.int=NULL,  show.beta0, ...)
\method{estimable}{default} (obj, cm, beta0, conf.int=NULL, show.beta0, joint.test=FALSE, ...)
\method{estimable}{mer}(obj, cm, beta0, conf.int=NULL,
               show.beta0, sim.mer=TRUE, n.sim=1000, ...) 
\method{estimable}{mlm}(obj, cm, beta0, conf.int=NULL,  show.beta0, ...)
%.wald(obj, cm,beta0=rep(0, ifelse(is.null(nrow(cm)), 1, nrow(cm))))
%.to.est(obj, params)
}
\arguments{
   \item{obj}{Regression (lm, glm, lme, mer, mlm) object. }
   \item{cm}{Vector, List, or Matrix specifying estimable linear functions or
     contrasts.  See below for details.}
   \item{beta0}{Vector of null hypothesis values}
   \item{conf.int}{Confidence level.  If provided, confidence intervals
     will be computed.}
   \item{joint.test}{Logical value. If TRUE a 'joint' Wald test for the
     hypothesis \eqn{L \beta=\beta_0}{L \%*\% beta=beta0} is performed.
     Otherwise 'row-wise' tests are performed, i.e. \eqn{(L
      \beta)_i=\beta_{0i}}{(L \%*\% beta)[i]=beta0[i]}
    }
   \item{show.beta0}{Logical value. If TRUE a column for beta0 will be
     included in the output table.  Defaults to TRUE when beta0 is
     specified, FALSE otherwise.}
   \item{sim.mer}{Logical value. If TRUE p-values and confidence
     intervals will be estimated using \code{mcmcsamp}.
   }
   \item{n.sim}{Number of MCMC samples to take in
     \code{mcmcsamp}.
   }
   \item{...}{ignored}
}
\details{
  \code{estimable} computes an estimate, test statitic, significance
  test, and (optional) confidence interval for each linear functions of
  the model coefficients specified by \code{cm}.

  The estimable function(s) may be specified via a vector, list, or
  matrix.  If \code{cm} is a vector, it should contained named elements
  each of which gives the coefficient to be applied to the
  corresponding parameter. These coefficients will be used to construct
  the contrast matrix, with unspecified model parameters assigned zero
  coefficients. If \code{cm} is a list, it should contain one or more
  coefficient vectors, which will be used to construct rows of the
  contrast matrix.  If \code{cm} is a matrix, column names must match (a
  subset of) the model parameters, and each row should contain the
  corresponding coefficient to be applied.  Model parameters which are
  not present in the set of column names of \code{cm} will be set to zero.
  
  The estimates and their variances are obtained by applying the
  contrast matrix (generated from) \code{cm} to the model estimates
  variance-covariance matrix.  Degrees of freedom are obtained from the
  appropriate model terms.
  
  The user is responsible for ensuring that the specified
  linear functions are meaningful.

  For computing contrasts among levels of a single factor,
  \code{fit.contrast} may be more convenient.  For computing contrasts
  between two specific combinations of model parameters, the
  \code{contrast} function in Frank Harrell's 'rms' library
  (formerly 'Design') may be more convenient.

  %The \code{.wald} function is called internally by \code{estimable} and
  %is not intended for direct use.
}
\note{
  The estimated fixed effect parameters of \code{lme} objects may have
  different degrees of freedom.  If a specified contrast includes
  nonzero coefficients for parameters with differing degrees of freedom,
  the smallest number of degrees of freedom is used and a warning
  message is issued.
  }
\value{
  Returns a matrix with one row per linear function.  Columns contain
  the beta0 value (optional, see \code{show.beta0} above), estimated
  coefficients, standard errors, t values, degrees of freedom, two-sided
  p-values, and the lower and upper endpoints of the
  1-alpha confidence intervals. 
}
\author{
  BXC (Bendix Carstensen) \email{bxc\@novonordisk.com}, 
  Gregory R. Warnes \email{greg@warnes.net},
  Soren Hojsgaard \email{sorenh@agrsci.dk}, and
  Randall C Johnson \email{rjohnson@ncifcrf.gov}
}
\seealso{
  \code{\link{fit.contrast}},
  \code{\link[stats]{lm}},
  \code{\link[nlme]{lme}},
  \code{\link[stats]{contrasts}},
  \code{\link[rms]{contrast}}
  }

\examples{
# setup example data
y <- rnorm(100)
x <-  cut(rnorm(100, mean=y, sd=0.25),c(-4,-1.5,0,1.5,4))
levels(x) <- c("A","B","C","D")
x2 <- rnorm(100, mean=y, sd=0.5)

# simple contrast and confidence interval
reg <- lm(y ~ x)
estimable(reg, c(    0,   1,    0,   -1) )  # full coefficient vector
estimable(reg, c("xB"=1,"xD"=-1) )          # just the nonzero terms


# Fit a spline with a single knot at 0.5 and plot the *pointwise*
# confidence intervals
library(gplots)
pm <- pmax(x2-0.5, 0) # knot at 0.5
reg2 <- lm(y ~ x + x2 + pm )

range <- seq(-2, 2, , 50)
tmp <- estimable(reg2,
                 cm=cbind(
                          '(Intercept)'=1,
                          'xC'=1,
                          'x2'=range,
                          'pm'=pmax(range-0.5, 0)
                           ),
                 conf.int=0.95)
plotCI(x=range, y=tmp[, 1], li=tmp[, 6], ui=tmp[, 7])

# Fit both linear and quasi-Poisson models to iris data, then compute
# joint confidence intervals on contrasts for the Species and
# Sepal.Width by Species interaction terms.
data(iris)
lm1  <- lm (Sepal.Length ~ Sepal.Width + Species + Sepal.Width:Species, data=iris)
glm1 <- glm(Sepal.Length ~ Sepal.Width + Species + Sepal.Width:Species, data=iris, 
            family=quasipoisson("identity"))

cm <- rbind(
            'Setosa vs. Versicolor'   = c(0, 0, 1, 0, 1, 0), 
            'Setosa vs. Virginica'    = c(0, 0, 0, 1, 0, 1),
            'Versicolor vs. Virginica'= c(0, 0, 1,-1, 1,-1)
            )
estimable(lm1, cm)
estimable(glm1, cm)
}
\keyword{ models }
\keyword{ regression }

