% $Id$
%
% $Log$
% Revision 1.8  2005/12/12 22:02:48  nj7w
% Updated version number for CRAN release
%
% Revision 1.7  2005/12/04 03:02:06  warnes
% Andrew Burgess reported that interleave() converts 1-column matrixes
% to vectors and provided a patch.  A slight modification of his patch
% has been applied.  There is now a 'drop' argument, which controls
% whether 'unnecessary' dimensions are dropped.  The default is FALSE.
%
% Revision 1.6  2005/09/12 15:42:45  nj7w
% Updated Greg's email
%
% Revision 1.5  2005/06/09 14:20:25  nj7w
% Updating the version number, and various help files to synchronize splitting of gregmisc bundle in 4 individual components.
%
% Revision 1.1.1.1  2005/05/25 22:07:33  nj7w
% Initial entry for individual package gdata
%
% Revision 1.4  2003/06/07 17:58:37  warnes
%
% - Fixed error in examples.  Had sqrt(var(x)/(n-1)) for the standard
%   error of the mean instead of sqrt(var(x)/n).
%
% Revision 1.3  2002/09/23 13:59:30  warnes
% - Modified all files to include CVS Id and Log tags.
%
% Revision 1.2  2002/04/09 00:51:32  warneg
%
% Checkin for version 0.5.3
%
% Revision 1.1  2002/02/20 21:41:54  warneg
% Initial checkin.
%
%


\name{interleave}
\alias{interleave}
\title{ Interleave Rows of Data Frames or Matrices }
\description{
  Interleave rows of data frames or Matrices.
}
\usage{
interleave(..., append.source=TRUE, sep=": ", drop=FALSE)
}
\arguments{
  \item{\dots}{ objects to be interleaved }
  \item{append.source}{Boolean Flag.  When \code{TRUE} (the default) the
    argument name will be appended to the row names to show the source of
    each row. }
  \item{sep}{Separator between the original row name and the object name.}
  \item{drop}{boolean flag - When TRUE, matrices containing one column
    will be converted to vectors.}
}
\details{
  This function creates a new matrix or data frame from its arguments.
  
  The new object will have all of the rows from the source objects
  interleaved. IE, it will contain row 1 of object 1, followed by row 1
  of object 2, .. row 1 of object 'n', row 2 of object 1, row 2 of
  object 2, ... row 2 of object 'n' ...
}
\value{
  Matrix containing the interleaved rows of the function arguments.
  }
\author{ Gregory R. Warnes \email{greg@warnes.net}
  }
\seealso{ \code{\link{cbind}}, \code{\link{rbind}}, \code{\link{combine}} }

\examples{

# Simple example
a <- matrix(1:10,ncol=2,byrow=TRUE)
b <- matrix(letters[1:10],ncol=2,byrow=TRUE)
c <- matrix(LETTERS[1:10],ncol=2,byrow=TRUE)
interleave(a,b,c)

# Useful example:
#
# Create a 2-way table of means, standard errors, and # obs

g1 <- sample(letters[1:5], 1000, replace=TRUE)
g2 <- sample(LETTERS[1:3], 1000, replace=TRUE )
dat <- rnorm(1000)

stderr <- function(x) sqrt( var(x,na.rm=TRUE) / nobs(x) )

means   <- tapply(dat, list(g1, g2), mean )
stderrs <- tapply(dat, list(g1, g2), stderr )
ns      <- tapply(dat, list(g1, g2), nobs )
blanks <- matrix( " ", nrow=5, ncol=3)

tab <- interleave( "Mean"=round(means,2),
                   "Std Err"=round(stderrs,2),
                   "N"=ns, " " = blanks, sep=" " )

print(tab, quote=FALSE)

# Using drop to control coercion to a lower dimensions:

m1 <- matrix(1:4)
m2 <- matrix(5:8)

interleave(m1, m2, drop=TRUE)  # This will be coerced to a vector

interleave(m1, m2, drop=FALSE) # This will remain a matrix


}
\keyword{category}
\keyword{array}

