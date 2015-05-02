% cbindX.Rd
%--------------------------------------------------------------------------
% What: Column-bind objects with different number of rows - help
% $Id$
% Time-stamp: <2008-08-05 13:38:45 ggorjan>
%--------------------------------------------------------------------------

\name{cbindX}

\alias{cbindX}

\title{Column-bind objects with different number of rows}

\description{
\code{cbindX} column-binds objects with different number of rows.
}

\usage{cbindX(...)}

\arguments{
  \item{\dots}{matrix and data.frame objects}
}

\details{

First the object with maximal number of rows is found. Other objects
that have less rows get (via \code{\link{rbind}}) additional rows with
\code{NA} values.  Finally, all objects are column-binded (via
\code{\link{cbind}}).

}

\value{See details}

\author{Gregor Gorjanc}

\seealso{Regular \code{\link{cbind}} and \code{\link{rbind}}}

\examples{

df1 <- data.frame(a=1:3, b=c("A", "B", "C"))
df2 <- data.frame(c=as.character(1:5), a=5:1)

ma1 <- matrix(as.character(1:4), nrow=2, ncol=2)
ma2 <- matrix(1:6, nrow=3, ncol=2)

cbindX(df1, df2)
cbindX(ma1, ma2)
cbindX(df1, ma1)
cbindX(df1, df2, ma1, ma2)
cbindX(ma1, ma2, df1, df2)

}

\keyword{misc}

%--------------------------------------------------------------------------
% cbindX.Rd ends here
