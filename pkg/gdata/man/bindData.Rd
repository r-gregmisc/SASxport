% bindData.Rd
%--------------------------------------------------------------------------
% What: Bind two data frames - help
% $Id$
% Time-stamp: <2008-12-30 13:49:50 ggorjan>
%--------------------------------------------------------------------------

\name{bindData}
\alias{bindData}

\title{Bind two data frames into a multivariate data frame}

\description{
  Usually data frames represent one set of variables and one needs to 
  bind/join them for multivariate analysis. When \code{\link{merge}} is not
  the approriate solution, \code{bindData} might perform an appropriate binding
  for two data frames. This is especially usefull when some variables are
  measured once, while others are repeated.
}

\usage{
  bindData(x, y, common)
}

\arguments{
  \item{x}{data.frame}
  \item{y}{data.frame}
  \item{common}{character, list of column names that are common to both
    input data frames}
}

\details{
  Data frames are joined in a such a way, that the new data frame has
  \eqn{c + (n_1 - c) + (n_2 - c)} columns, where \eqn{c} is the number of
  common columns, and \eqn{n_1} and \eqn{n_2} are the number of columns 
  in the first and in the second data frame, respectively.
}

\value{
  A data frame.
}

\author{Gregor Grojanc}

\seealso{
  \code{\link[base]{merge}},
  \code{\link{wideByFactor}}
}

\examples{
n1 <- 6
n2 <- 12
n3 <- 4
## Single trait 1
num <- c(5:n1, 10:13)
(tmp1 <- data.frame(y1=rnorm(n=n1),
                    f1=factor(rep(c("A", "B"), n1/2)),
                    ch=letters[num],
                    fa=factor(letters[num]),
                    nu=(num) + 0.5,
                    id=factor(num), stringsAsFactors=FALSE))

## Single trait 2 with repeated records, some subjects also in tmp1 
num <- 4:9
(tmp2 <- data.frame(y2=rnorm(n=n2),
                    f2=factor(rep(c("C", "D"), n2/2)),
                    ch=letters[rep(num, times=2)],
                    fa=factor(letters[rep(c(num), times=2)]),
                    nu=c((num) + 0.5, (num) + 0.25),
                    id=factor(rep(num, times=2)), stringsAsFactors=FALSE))

## Single trait 3 with completely distinct set of subjects
num <- 1:4
(tmp3 <- data.frame(y3=rnorm(n=n3),
                    f3=factor(rep(c("E", "F"), n3/2)),
                    ch=letters[num],
                    fa=factor(letters[num]),
                    nu=(num) + 0.5,
                    id=factor(num), stringsAsFactors=FALSE))

## Combine all datasets
(tmp12 <- bindData(x=tmp1, y=tmp2, common=c("id", "nu", "ch", "fa")))
(tmp123 <- bindData(x=tmp12, y=tmp3, common=c("id", "nu", "ch", "fa")))

## Sort by subject
tmp123[order(tmp123$ch), ]
}

\keyword{manip}
\keyword{misc}

%--------------------------------------------------------------------------
% bindData.Rd ends here