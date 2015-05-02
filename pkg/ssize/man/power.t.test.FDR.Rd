\name{power.t.test.FDR}
\alias{power.t.test.FDR}
\encoding{latin1}
\title{Power calculations for one and two sample t tests using FDR correction}
\usage{
power.t.test.FDR <- function (sd=1, n=NULL, delta=NULL,
                              FDR.level=0.05,
                              pi0,
                              power=NULL, 
                              type=c("two.sample", "one.sample", "paired"),
                              alternative=c("two.sided", "one.sided")) 
}
\arguments{
 \item{n}{Number of observations (per group)}
 \item{delta}{True difference in means}
 \item{sd}{Standard deviation}
 \item{FDR.level}{False Discovery Rate (expected ratio of false
   discoveries among all discoveries)}
 \item{pi0}{Proportion of true null hypothesies (fraction of tests that
   with no difference)}
 \item{power}{Power of test (1 minus Type II error probability)}
 \item{type}{Type of t test}
 \item{alternative}{One- or two-sided test}
 \item{strict}{Use strict interpretation in two-sided case}
}
\description{
 Compute power of test, or determine parameters to obtain target power.
}

\details{
  Exactly one of the parameters \code{n}, \code{delta}, \code{power},
  \code{sd}, and \code{FDR.level} must be passed as NULL, and that
  parameter is determined from the others. Notice that the last two have
  non-NULL defaults so NULL must be explicitly passed if you want to
  compute them.

%  If \code{strict=TRUE} is used, the power will include the probability of
%  rejection in the opposite direction of the true effect, in the two-sided 
%  case. Without this the power will be half the significance level if the 
%  true difference is zero.
}
\value{
  Object of class \code{"power.htest"}, a list of the arguments
  (including the computed one) augmented with \code{method} and
  \code{note} elements. 
}

\author{Peng Liu, based on \code{power.t.test} code by Peter Dalgaard,
  which in turn is based on previous work by Claus
  \enc{Ekstrøm}{Ekstrom}}

\note{
  \code{uniroot} is used to solve power equation for unknowns, so
  you may see errors from it, notably about inability to bracket the
  root when invalid arguments are given.
}
\seealso{\code{\link{t.test.FDR}}, \code{\link{uniroot}}}

\examples{

 ## Compute power given sd, n, delta, FDR & pi.0
 power.t.test.FDR(sd=1, n=5, delta=2, FDR.level=0.05, pi0=0.95,
                  power=NULL, type="two.sample", alternative="two.sided")

 ## Compute power
 power.t.test.FDR(n=20, delta=1, FDR=0.05, pi0=0.75)
 power.t.test.FDR(n=29, delta=1, FDR=0.05, pi0=0.75)

 ## compute n
 power.t.test.FDR(n=NULL, sd=1, power=.90, delta=1, FDR=0.05, pi0=0.975)
 power.t.test.FDR(n=NULL, sd=1, power=.90, delta=1, FDR=0.05, pi0=0.975, alt="one.sided")


 ## compute sd
 power.t.test.FDR(sd=NULL, n=29, power=.90, delta=1, FDR=0.05, pi0=0.975)

 ## compute FDR level
 power.t.test.FDR(sd=1, n=29, power=.90, delta=1, FDR=NULL, pi0=0.975)


}
\keyword{htest}


