\name{matchcols}
\alias{matchcols}
\title{Select columns names matching certain critera}
\description{
  This function allows easy selection of the column names of an object
  using a set of inclusion and exclusion critera.
}
\usage{
matchcols(object, with, without, method=c("and","or"), ...)
}
\arguments{
  \item{object}{Matrix or dataframe}
  \item{with, without}{Vector of regular expression patterns}
  \item{method}{One of "and" or "or"}
  \item{\dots}{Optional arguments to \code{grep}}
}
\value{
  Vector of column names which match all (\code{method="and"}) or any
  (\code{method="or"}) of the patterns specified in \code{with}, but
  none of the patterns specified in \code{without}.
}

\author{Gregory R. Warnes \email{greg@warnes.net}}
\seealso{ \code{\link[base]{grep}} }
\examples{

# create a matrix with a lot of named columns
x <- matrix( ncol=30, nrow=5 )
colnames(x) <- c("AffyID","Overall Group Means: Control",
                     "Overall Group Means: Moderate",
                     "Overall Group Means: Marked",
                     "Overall Group Means: Severe",
                     "Overall Group StdDev: Control",
                     "Overall Group StdDev: Moderate",
                     "Overall Group StdDev: Marked",
                     "Overall Group StdDev: Severe",
                     "Overall Group CV: Control",
                     "Overall Group CV: Moderate",
                     "Overall Group CV: Marked",
                     "Overall Group CV: Severe",
                     "Overall Model P-value",
                     "Overall Model: (Intercept): Estimate",
                     "Overall Model: Moderate: Estimate",
                     "Overall Model: Marked: Estimate",
                     "Overall Model: Severe: Estimate",
                     "Overall Model: (Intercept): Std. Error",
                     "Overall Model: Moderate: Std. Error",
                     "Overall Model: Marked: Std. Error",
                     "Overall Model: Severe: Std. Error",
                     "Overall Model: (Intercept): t value",
                     "Overall Model: Moderate: t value",
                     "Overall Model: Marked: t value",
                     "Overall Model: Severe: t value",
                     "Overall Model: (Intercept): Pr(>|t|)",
                     "Overall Model: Moderate: Pr(>|t|)",
                     "Overall Model: Marked: Pr(>|t|)",
                     "Overall Model: Severe: Pr(>|t|)")

# Get the columns which give estimates or p-values
# only for marked and severe groups
matchcols(x, with=c("Pr", "Std. Error"),
             without=c("Intercept","Moderate"),
             method="or"
          )

# Get just the column which give the p-value for the intercept
matchcols(x, with=c("Intercept", "Pr") )
                     
}
\keyword{manip}
