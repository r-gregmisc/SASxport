% $Id$
%
\name{ci}
\alias{ci}
\alias{ci.default}
\alias{ci.binom}
\alias{ci.lm}
\alias{ci.lme}
\alias{ci.mer}
\alias{ci.estimable}
\title{Compute Confidence Intervals}
\description{ Compute and display confidence intervals for model
  estimates.  Methods are provided for the mean of a numeric vector
  \code{ci.default}, the probability of a binomial vector
  \code{ci.binom}, and for \code{lm}, \code{lme}, and \code{mer} objects are
  provided. }
\usage{
  ci(x, confidence=0.95, alpha=1 - confidence, ...)
  \method{ci}{default}(x, confidence=0.95, alpha=1-confidence, na.rm=FALSE, ...)
  \method{ci}{binom}(x, confidence=0.95, alpha=1-confidence, ...)
  \method{ci}{lm}(x, confidence=0.95, alpha=1-confidence, ...)
  \method{ci}{lme}(x, confidence=0.95, alpha=1-confidence, ...)
  \method{ci}{mer}(x, confidence=0.95, alpha=1-confidence, n.sim=10000, ...) 
  \method{ci}{estimable}(x, confidence=0.95, alpha=1-confidence, ...) 
}
\arguments{
  \item{x}{ object from which to compute confidence intervals. }
  \item{confidence}{ confidence level. Defaults to 0.95. }
  \item{alpha}{type one error rate.  Defaults to 1.0-\code{confidence} }
  \item{na.rm}{boolean indicating whether missing values should be
    removed. Defaults to \code{FALSE}.}
  \item{\dots}{Arguments for methods}
  \item{n.sim}{Number of samples to take in \code{mcmcsamp}.}
}
%\details{
%  ~~ If necessary, more details than the __description__  above ~~
%}
\value{
  vector or matrix with one row per model parameter and elements/columns
  \code{Estimate}, \code{CI lower}, \code{CI upper}, \code{Std. Error},
  \code{DF} (for lme objects only), and \code{p-value}.
}
\author{ Gregory R. Warnes \email{greg@warnes.net}
}
\seealso{
  \code{\link[stats]{confint}},
  \code{\link[stats]{lm}},
  \code{\link[stats]{summary.lm}}
}

\examples{

# mean and confidence interval 
ci( rnorm(10) )

# binomial proportion and exact confidence interval
b <- rbinom( prob=0.75, size=1, n=20 )
ci.binom(b) # direct call
class(b) <- 'binom'
ci(b)       # indirect call

# confidence intervals for regression parameteres
data(state)
reg  <-  lm(Area ~ Population, data=as.data.frame(state.x77))
ci(reg) 

%\dontrun{
# mer example
library(lme4)
fm2 <- lmer(Reaction ~ Days + (1|Subject) + (0+Days|Subject), sleepstudy)
ci(fm2)
%}


}
\keyword{ regression }
