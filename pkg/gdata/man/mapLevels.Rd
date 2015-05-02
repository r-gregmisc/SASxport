% mapLevels.Rd
%--------------------------------------------------------------------------
% What: Mapping levels
% $Id: mapLevels.Rd,v 1.1 2006/03/29 13:47:10 ggorjan Exp ggorjan $
% Time-stamp: <2006-11-01 00:15:57 ggorjan>
%--------------------------------------------------------------------------

\name{mapLevels}

\alias{mapLevels}
\alias{mapLevels.default}
\alias{mapLevels.factor}
\alias{mapLevels.character}
\alias{mapLevels.list}
\alias{mapLevels.data.frame}

\alias{print.levelsMap}
\alias{print.listLevelsMap}

\alias{is.levelsMap}
\alias{is.listLevelsMap}

\alias{as.levelsMap}
\alias{as.listLevelsMap}

\alias{.checkLevelsMap}
\alias{.checkListLevelsMap}

\alias{"[.levelsMap"}
\alias{"[.listLevelsMap"}

\alias{c.levelsMap}
\alias{c.listLevelsMap}

\alias{unique.levelsMap}
\alias{sort.levelsMap}

\alias{mapLevels<-}
\alias{mapLevels<-.default}
\alias{mapLevels<-.factor}
\alias{mapLevels<-.character}
\alias{mapLevels<-.list}
\alias{mapLevels<-.data.frame}

\title{Mapping levels}

\description{

\code{mapLevels} produces a map with information on levels and/or
internal integer codes. As such can be conveniently used to store level
mapping when one needs to work with internal codes of a factor and later
transfrorm back to factor or when working with several factors that
should have the same levels and therefore the same internal coding.

}

\usage{

mapLevels(x, codes=TRUE, sort=TRUE, drop=FALSE, combine=FALSE, \dots)
mapLevels(x) <- value

}

\arguments{
  \item{x}{object whose levels will be mapped, look into details}
  \item{codes}{boolean, create integer levelsMap (with internal
    codes) or character levelsMap (with level names)}
  \item{sort}{boolean, sort levels of character \code{x}, look into
    details}
  \item{drop}{boolean, drop unused levels}
  \item{combine}{boolean, combine levels, look into details}
  \item{\dots}{additional arguments for \code{sort}}
  \item{value}{levelsMap or listLevelsMap, output of \code{mapLevels}
    methods or constructed by user, look into details}
}

\section{mapLevels}{

\code{mapLevels} function was written primarly for work with
\dQuote{factors}, but is generic and can also be used with
\dQuote{character}, \dQuote{list} and \dQuote{data.frame}, while
\dQuote{default} method produces error. Here the term levels is also
used for unique character values.

When \code{codes=TRUE} \bold{integer \dQuote{levelsMap}} with
information on mapping internal codes with levels is produced. Output
can be used to transform integer to factor or remap factor levels as
described bellow. With \code{codes=FALSE} \bold{character
\dQuote{levelsMap}} is produced. The later is usefull, when one would
like to remap factors or combine factors with some overlap in levels as
described in \code{mapLevels<-} section and shown in examples.

\code{sort} argument provides possibility to sort levels of
\dQuote{character} \code{x} and has no effect when \code{x} is a
\dQuote{factor}.

Argument \code{combine} has effect only in \dQuote{list} and
\dQuote{data.frame} methods and when \code{codes=FALSE} i.e. with
\bold{character \dQuote{levelsMaps}}. The later condition is necesarry
as it is not possible to combine maps with different mapping of level
names and integer codes. It is assumed that passed \dQuote{list} and
\dQuote{data.frame} have all components for which methods
exist. Otherwise error is produced.

}

\section{levelsMap and listLevelsMap}{

Function \code{mapLevels} returns a map of levels. This map is of class
\dQuote{levelsMap}, which is actually a list of length equal to number
of levels and with each component of length 1. Components need not be of
length 1. There can be either integer or character
\dQuote{levelsMap}. \bold{Integer \dQuote{levelsMap}} (when
\code{codes=TRUE}) has names equal to levels and components equal to
internal codes. \bold{Character \dQuote{levelsMap}} (when
\code{codes=FALSE}) has names and components equal to levels. When
\code{mapLevels} is applied to \dQuote{list} or \dQuote{data.frame},
result is of class \dQuote{listLevelsMap}, which is a list of
\dQuote{levelsMap} components described previously. If
\code{combine=TRUE}, result is a \dQuote{levelsMap} with all levels in
\code{x} components.

For ease of inspection, print methods unlists \dQuote{levelsMap} with
proper names. \code{mapLevels<-} methods are fairly general and
therefore additional convenience methods are implemented to ease the
work with maps: \code{is.levelsMap} and \code{is.listLevelsMap};
\code{as.levelsMap} and \code{as.listLevelsMap} for coercion of user
defined maps; generic \code{"["} and \code{c} for both classes (argument
\code{recursive} can be used in \code{c} to coerce
\dQuote{listLevelsMap} to \dQuote{levelsMap}) and generic \code{unique}
and \code{sort} (generic from \R 2.4) for \dQuote{levelsMap}.

}

\section{mapLevels<-}{

Workhorse under \code{mapLevels<-} methods is
\code{\link{levels<-}}. \code{mapLevels<-} just control the assignment
of \dQuote{levelsMap} (integer or character) or \dQuote{listLevelsMap}
to \code{x}. The idea is that map values are changed to map names as
indicated in \code{\link{levels}} examples. \bold{Integer
\dQuote{levelsMap}} can be applied to \dQuote{integer} or
\dQuote{factor}, while \bold{character \dQuote{levelsMap}} can be
applied to \dQuote{character} or \dQuote{factor}. Methods for
\dQuote{list} and \dQuote{data.frame} can work only on mentioned atomic
components/columns and can accept either \dQuote{levelsMap} or
\dQuote{listLevelsMap}. Recycling occurs, if length of \code{value} is not
the same as number of components/columns of a \dQuote{list/data.frame}.
}

\value{

\code{mapLevels()} returns \dQuote{levelsMap} or \dQuote{listLevelsMap}
objects as described in levelsMap and listLevelsMap section.

Result of \code{mapLevels<-} is always a factor with remapped levels or
a \dQuote{list/data.frame} with remapped factors.

}

\author{Gregor Gorjanc}

\seealso{
  \code{\link{factor}}, \code{\link{levels}} and \code{\link{unclass}}
}

\examples{

## --- Integer levelsMap ---

(f <- factor(sample(letters, size=20, replace=TRUE)))
(mapInt <- mapLevels(f))

## Integer to factor
(int <- as.integer(f))
(mapLevels(int) <- mapInt)
all.equal(int, f)

## Remap levels of a factor
(fac <- factor(as.integer(f)))
(mapLevels(fac) <- mapInt) # the same as levels(fac) <- mapInt
all.equal(fac, f)

## --- Character levelesMap ---

f1 <- factor(letters[1:10])
f2 <- factor(letters[5:14])

## Internal codes are the same, but levels are not
as.integer(f1)
as.integer(f2)

## Get character levelsMaps and combine them
mapCha1 <- mapLevels(f1, codes=FALSE)
mapCha2 <- mapLevels(f2, codes=FALSE)
(mapCha <- c(mapCha1, mapCha2))

## Remap factors
mapLevels(f1) <- mapCha # the same as levels(f1) <- mapCha
mapLevels(f2) <- mapCha # the same as levels(f2) <- mapCha

## Internal codes are now "consistent" among factors
as.integer(f1)
as.integer(f2)

## Remap characters to get factors
f1 <- as.character(f1); f2 <- as.character(f2)
mapLevels(f1) <- mapCha
mapLevels(f2) <- mapCha

## Internal codes are now "consistent" among factors
as.integer(f1)
as.integer(f2)

}

\keyword{misc}
\keyword{manip}

%--------------------------------------------------------------------------
% mapLevels.Rd ends here
