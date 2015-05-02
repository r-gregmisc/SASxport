% $Id$
%
\name{coefFrame}
\alias{coefFrame}
\title{Return model parameters in a data frame}
\description{Fits a model to each subgroup defined by \code{by}, then
  returns a data frame with one row for each fit and one column for each
  parameter.
}
\usage{
coefFrame(mod, data, by = NULL, fit.on = TRUE, fitfun,
          keep.unused.levels = TRUE, byvar.sep = "\001", ...)

}
\arguments{
  \item{mod}{a model formula, to be passed to by \code{fitfun}.}
  \item{data}{a data frame, row subsets of which will be used as the
    \code{data} argument to \code{fitfun}.}
  \item{by}{names of columns in \code{x} that will be used to define the
    subgroups.}
  \item{fit.on}{a logical vector indicating which rows of \code{x} are
    to be used to fit the model (like the \code{subset} argument in a
    lot of other functions). Can be
    given in terms of variables in \code{x}}
  \item{fitfun}{a model fitting function (e.g. lm, nls). More
    specifically, a function that expects at least a formula object (as the
    first argument) and a data.frame object (passed as an argument named
    \code{data}) and
    returns a model object for which a \code{coef} method
    has been defined (e.g. coef.lm, coef.nls) to extract fit values of
    model parameters.}
  \item{keep.unused.levels}{Include rows in output for all unique values
    of \code{by}, even those which were excluded by
    \code{fit.on}. The default value \code{TRUE} should be left alone
    if you are going to go on to pass the result to \code{backFit}.}
  \item{byvar.sep}{passed to frameApply, used to form the
    subsets of the data.}
  \item{...}{other arguments to pass to \code{fitfun}.}
}
\value{a data frame with a row for each unique row of \code{x[by]}, and
  column for each model paramter, as well as columns specified in \code{by}.   
}
\examples{
# load example data
library(gtools)
data(ELISA)

# Coefficients for four parameter logistic fits:
coefFrame(log(Signal) ~ SSfpl(log(Concentration), A, B, xmid, scal),
           data = ELISA, fitfun = nls,
           by = c("PlateDay", "Read"),
           fit.on = Description == "Standard" & Concentration != 0)

# Coefficients for linear fits:
coefFrame(log(Signal) ~ log(Concentration), 
           data = ELISA, fitfun = lm, 
           by = c("PlateDay", "Read"),
           fit.on = Description == "Standard" & Concentration != 0 )

# Example passing arguments to fitfun, and example of
# error handling during model fitting:
ELISA$Signal[1] <- NA
coefFrame(log(Signal) ~ log(Concentration), 
           data = ELISA, fitfun = lm, na.action = na.fail,
           by = c("PlateDay", "Read"),
           fit.on = Description == "Standard" & Concentration != 0 )


}
\author{Jim Rogers \email{james.a.rogers@pfizer.com}}
\keyword{models}


