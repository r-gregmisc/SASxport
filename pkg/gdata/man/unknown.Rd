% unknown.Rd
%--------------------------------------------------------------------------
% What: Change given unknown value to NA and vice versa man page
% $Id$
% Time-stamp: <2007-08-17 20:18:54 ggorjan>
%--------------------------------------------------------------------------

\name{unknownToNA}

\alias{isUnknown}
\alias{isUnknown.default}
\alias{isUnknown.POSIXlt}
\alias{isUnknown.list}
\alias{isUnknown.data.frame}
\alias{isUnknown.matrix}

\alias{unknownToNA}
\alias{unknownToNA.default}
\alias{unknownToNA.factor}
\alias{unknownToNA.list}
\alias{unknownToNA.data.frame}

\alias{NAToUnknown}
\alias{NAToUnknown.default}
\alias{NAToUnknown.factor}
\alias{NAToUnknown.list}
\alias{NAToUnknown.data.frame}

\concept{missing}

\title{Change unknown values to NA and vice versa}

\description{

Unknown or missing values (\code{NA} in \R) can be represented in
various ways (as 0, 999, etc.) in different programs. \code{isUnknown},
\code{unknownToNA}, and \code{NAToUnknown} can help to change unknown
values to \code{NA} and vice versa.

}

\usage{

isUnknown(x, unknown=NA, \dots)
unknownToNA(x, unknown, warning=FALSE, \dots)
NAToUnknown(x, unknown, force=FALSE, call.=FALSE, \dots)

}

\arguments{
  \item{x}{generic, object with unknown value(s)}
  \item{unknown}{generic, value used instead of \code{NA}}
  \item{warning}{logical, issue warning if \code{x} already has \code{NA}}
  \item{force}{logical, force to apply already existing value in \code{x}}
  \item{\dots}{arguments pased to other methods (as.character for POSIXlt
    in case of isUnknown)}
  \item{call.}{logical, look in \code{\link{warning}}}
}

\details{

This functions were written to handle different variants of
\dQuote{other \code{NA}} like representations that are usually used in
various external data sources. \code{unknownToNA} can help to change
unknown values to \code{NA} for work in \R, while \code{NAToUnknown} is
meant for the opposite and would usually be used prior to export of data
from \R. \code{isUnknown} is utility function for testing for unknown
values.

All functions are generic and the following classes were tested to work
with latest version: \dQuote{integer}, \dQuote{numeric},
\dQuote{character}, \dQuote{factor}, \dQuote{Date}, \dQuote{POSIXct},
\dQuote{POSIXlt}, \dQuote{list}, \dQuote{data.frame} and
\dQuote{matrix}. For others default method might work just fine.

\code{unknownToNA} and \code{isUnknown} can cope with multiple values in
\code{unknown}, but those should be given as a \dQuote{vector}. If not,
coercing to vector is applied. Argument \code{unknown} can be feed also
with \dQuote{list} in \dQuote{list} and \dQuote{data.frame} methods.

If named \dQuote{list} or \dQuote{vector} is passed to argument
\code{unknown} and \code{x} is also named, matching of names will occur.

Recycling occurs in all \dQuote{list} and \dQuote{data.frame} methods,
when \code{unknown} argument is not of the same length as \code{x} and
\code{unknown} is not named.

Argument \code{unknown} in \code{NAToUnknown} should hold value that is
not already present in \code{x}. If it does, error is produced and one
can bypass that with \code{force=TRUE}, but be warned that there is no
way to distinguish values after this action. Use at your own risk!
Anyway, warning is issued about new value in \code{x}. Additionally,
caution should be taken when using \code{NAToUnknown} on factors as
additional level (value of \code{unknown}) is introduced. Then, as
expected, \code{unknownToNA} removes defined level in \code{unknown}. If
\code{unknown="NA"}, then \code{"NA"} is removed from factor levels in
\code{unknownToNA} due to consistency with conversions back and forth.

Unknown representation in \code{unknown} should have the same class as
\code{x} in \code{NAToUnknown}, except in factors, where \code{unknown}
value is coerced to character anyway. Silent coercing is also applied,
when \dQuote{integer} and \dQuote{numeric} are in question. Otherwise
warning is issued and coercing is tried. If that fails, \R introduces
\code{NA} and the goal of \code{NAToUnknown} is not reached.

\code{NAToUnknown} accepts only single value in \code{unknown} if
\code{x} is atomic, while \dQuote{list} and \dQuote{data.frame} methods
accept also \dQuote{vector} and \dQuote{list}.

\dQuote{list/data.frame} methods can work on many components/columns. To
reduce the number of needed specifications in \code{unknown} argument,
default unknown value can be specified with component ".default". This
matches component/column ".default" as well as all other undefined
components/columns! Look in examples.

}

\value{

\code{unknownToNA} and \code{NAToUnknown} return modified
\code{x}. \code{isUnknown} returns logical values for object \code{x}.

}

\author{Gregor Gorjanc}

\seealso{\code{\link{is.na}}}

\examples{

xInt <- c(0, 1, 0, 5, 6, 7, 8, 9, NA)
isUnknown(x=xInt, unknown=0)
isUnknown(x=xInt, unknown=c(0, NA))
(xInt <- unknownToNA(x=xInt, unknown=0))
(xInt <- NAToUnknown(x=xInt, unknown=0))

xFac <- factor(c("0", 1, 2, 3, NA, "NA"))
isUnknown(x=xFac, unknown=0)
isUnknown(x=xFac, unknown=c(0, NA))
isUnknown(x=xFac, unknown=c(0, "NA"))
isUnknown(x=xFac, unknown=c(0, "NA", NA))
(xFac <- unknownToNA(x=xFac, unknown="NA"))
(xFac <- NAToUnknown(x=xFac, unknown="NA"))

xList <- list(xFac=xFac, xInt=xInt)
isUnknown(xList, unknown=c("NA", 0))
isUnknown(xList, unknown=list("NA", 0))
tmp <- c(0, "NA")
names(tmp) <- c(".default", "xFac")
isUnknown(xList, unknown=tmp)
tmp <- list(.default=0, xFac="NA")
isUnknown(xList, unknown=tmp)

(xList <- unknownToNA(xList, unknown=tmp))
(xList <- NAToUnknown(xList, unknown=999))

}

\keyword{manip}
\keyword{NA}

%--------------------------------------------------------------------------
% unknown.Rd ends here
