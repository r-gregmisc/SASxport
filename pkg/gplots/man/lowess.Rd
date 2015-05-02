% $Id$
%
% $Log$
% Revision 1.7  2005/06/09 14:20:28  nj7w
% Updating the version number, and various help files to synchronize splitting of gregmisc bundle in 4 individual components.
%
% Revision 1.1.1.1  2005/05/25 22:15:30  nj7w
% Initial submission as an individual package
%
% Revision 1.6  2003/12/03 02:46:51  warnes
% - match function argument defaults with 'usage'
%
% Revision 1.5  2002/09/23 13:59:30  warnes
% - Modified all files to include CVS Id and Log tags.
%
%

\name{lowess}
\alias{lowess}
\alias{lowess.default}
\alias{lowess.formula}
\title{Scatter Plot Smoothing}
\usage{
lowess(x, ...)
\method{lowess}{default}(x, y = NULL, f = 2/3, iter = 3, delta = 0.01 *
                  diff(range(x)), ...)
\method{lowess}{formula}(formula,data = parent.frame(), subset, na.action, 
               f=2/3,  iter=3, delta=.01*diff(range(mf[-response])), ... )
}
\alias{lowess}
\arguments{
  \item{formula}{ formula providing a single dependent variable (y) and
    an single independent variable (x) to use as coordinates in the
    scatter plot.}
  \item{data}{a data.frame (or list) from which the variables in `formula'
          should be taken.}
  \item{subset}{ an optional vector specifying a subset of observations to be
          used in the fitting process. }
  \item{x, y}{vectors giving the coordinates of the points in the scatter plot.
    Alternatively a single plotting structure can be specified.}
  \item{f}{the smoother span. This gives the proportion of points in
    the plot which influence the smooth at each value.
    Larger values give more smoothness.}
  \item{iter}{the number of robustifying iterations which should be
    performed.
    Using smaller values of \code{iter} will make \code{lowess} run faster.}
  \item{delta}{values of \code{x} which lie within \code{delta}
    of each other replaced by a single value in the output from
    \code{lowess}.}
  \item{na.action}{a function which indicates what should happen when the data
          contain `NA's.  The default is set by the `na.action' setting
          of `options', and is `na.fail' if that is unset. The
          ``factory-fresh'' default is `na.omit'.}
  \item{...}{parameters for methods.}
}
\description{
  This function performs the computations for the
  \emph{LOWESS} smoother (see the reference below).
  \code{lowess} returns a list containing components
  \code{x} and \code{y} which give the coordinates of the smooth.
  The smooth should be added to a plot of the original
  points with the function \code{lines}.
}
\references{
  Cleveland, W. S. (1979)
  Robust locally weighted regression and smoothing scatterplots.
  \emph{J. Amer. Statist. Assoc.} \bold{74}, 829--836.

  Cleveland, W. S. (1981)
  LOWESS: A program for smoothing scatterplots by robust locally weighted
  regression. \emph{The American Statistician}, \bold{35}, 54.
}
\seealso{\code{\link{loess}} (in package \code{modreg}), a newer
  formula based version of \code{lowess} (with different defaults!).
}
\examples{
data(cars)

# default method
plot(cars, main = "lowess(cars)")
lines(lowess(cars), col = 2)
lines(lowess(cars, f=.2), col = 3)
legend(5, 120, c(paste("f = ", c("2/3", ".2"))), lty = 1, col = 2:3)

# formula method
plot(dist ~ speed, data=cars, main = "lowess(cars)")
lines(lowess(dist ~ speed, data=cars), col = 2)
lines(lowess(dist ~ speed, data=cars, f=.2), col = 3)
legend(5, 120, c(paste("f = ", c("2/3", ".2"))), lty = 1, col = 2:3)

}
\keyword{smooth}
