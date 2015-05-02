% Come material taken from src/library/utils/man/object.size.Rd
% Part of the R package, http://www.R-project.org
% Copyright 1995-2007 R Core Development Team
% Distributed under GPL 2 or later

\name{object.size}
\alias{object.size}
\alias{c.object_sizes}
\alias{as.object_sizes}
\alias{is.object_sizes}
\alias{format.object_sizes}
\alias{print.object_sizes}

\title{Report the Space Allocated for Objects}
\description{
  Provides an estimate of the memory that is being used to store \R objects.
}
\usage{
object.size(\dots)

\method{is}{object_sizes}(x)

\method{as}{object_sizes}(x)

\method{c}{object_sizes}(\dots, recursive=FALSE)

\method{format}{object_sizes}(x, humanReadable=getOption("humanReadable"), standard="IEC", units,
       digits=1, width=NULL, sep=" ", justify = c("right", "left"),
\dots)

\method{print}{object_sizes}(x, quote=FALSE, humanReadable=getOption("humanReadable"),
      standard="IEC", units, digits=1, width=NULL, sep=" ",
      justify = c("right", "left"), \dots)

}
\arguments{
  \item{\dots}{\code{object.size}: \R objects;
    \code{print} and \code{format}: arguments to be passed to other
    methods.
  }
  \item{x}{output from \code{object.size}}
  \item{quote}{logical, indicating whether or not the result should be
    printed with surrounding quotes.}
  \item{humanReadable}{logical, use the \dQuote{human readable} format.}
  \item{standard,units,digits,width,sep,justify}{See the man page for
    \code{\link{humanReadable}}.
   }
   \item{recursive}{See the man page for \code{\link[base]{c}}. }
}
\details{

  \emph{This is a modified copy of the man page for utils::object.size in R
     2.2.1.}

  Exactly which parts of the memory allocation should be attributed
  to which object is not clear-cut.  This function merely provides a
  rough indication: it should be reasonably accurate for atomic
  vectors, but does not detect if elements of a list are shared, for
  example.  (Sharing amongst elements of a character vector is taken
  into account, but not that between character vectors in a single
  object.)

  The calculation is of the size of the object, and excludes the
  space needed to store its name in the symbol table.

  Associated space (e.g., the environment of a function and what the
  pointer in a \code{EXTPTRSXP} points to) is not included in the
  calculation.

  Object sizes are larger on 64-bit builds than 32-bit ones, but
  will very likely be the same on different platforms with the same
  word length and pointer size.

  % Modificitaion start
  \emph{Changes}

  Class of returned object is \code{c("object_sizes", "numeric")} with
  appropriate \code{print} and \code{c} methods.

  By default \code{object.size} outputs size in bytes, but human
  readable format similar to \code{ls}, \code{df} or \code{du} shell
  commands can be displayed by calling \code{humanReadable} directly,
  calling \code{print} with the argument \code{humanReadable=TRUE}, or
  by setting \code{options(humanReadable=TRUE)}.

  % Modificitaion end

}
\value{
  A numeric vector class \code{c("object_sizes", "numeric")} containing
  estimated memory allocation attributable to the objects in bytes.
}
\seealso{
  \code{\link[utils]{object.size}} in package 'utils' for the standard
  version of this function,
  \code{\link{Memory-limits}} for the design limitations on object size,
  \code{\link{humanReadable}} for human readable format.
}

\examples{
object.size(letters)
object.size(ls)
## find the 10 largest objects in the base package
allObj <- sapply(ls("package:base"),
            function(x)
                object.size(get(x, envir = baseenv()))
            )

( bigObj <- as.object_sizes(rev(sort(allObj))[1:10] ) )
print(bigObj, humanReadable=TRUE)


as.object_sizes(14567567)

\dontshow{
    optionsOrig <- options("humanReadable")
}

options(humanReadable=TRUE)
(
    z <- object.size(letters,
                     c(letters, letters),
                     rep(letters, 100),
                     rep(letters, 10000)
                     )
)
is.object_sizes(z)
as.object_sizes(14567567)

\dontshow{
    options(optionsOrig)
}

}
\keyword{utilities}
