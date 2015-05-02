\name{humanReadable}

\alias{humanReadable}

\title{Print Byte Size in Human Readable Format}

\description{

\code{humanReadable} converts integer byte sizes to a human readable units such as
kB, MB, GB, etc.

}

\usage{
humanReadable(x, units="auto", standard=c("IEC", "SI", "Unix"),
              digits=1, width=NULL, sep=" ", justify=c("right", "left") )
}

\arguments{
  \item{x}{integer, byte size}
  \item{standard}{character, "IEC" for powers of 1024 ('MiB'), "SI" for
    powers of 1000 ('MB'), or "Unix" for powers of 1024 ('M').  See
    details.}
  \item{units}{character, unit to use for all values (optional), one of
    "auto", "bytes", or an appropriate unit corresponding to
    \code{standard}.}
  \item{digits}{integer, number of digits after decimal point}
  \item{width}{integer, width of number string}
  \item{sep}{character, separator between number and unit}
  \item{justify}{two-element vector specifiy the alignment for the number
    and unit components of the size.  Each element should be one of
    "none", "left", "right", or "center"}
}

\details{

The basic unit used to store information in computers is a bit. Bits are
represented as zeroes and ones - binary number system. Although, the binary
number system is not the same as the decimal number system, decimal prefixes
for binary multiples such as kilo and mega are often used. In the decimal system
kilo represent 1000, which is close to \eqn{1024 = 2^{10}} in the binary system.
This sometimes causes problems as it is not clear which powers (2 or 10) are used
in a notation like 1 kB. To overcome this problem International Electrotechnical
Commission (IEC) has provided the following solution to this problem:

\tabular{lrcll}{
Name      \tab System  \tab Symbol \tab Size             \tab Conversion    \cr
byte      \tab binary  \tab B      \tab \eqn{2^3}        \tab    8 bits     \cr
kilobyte  \tab decimal \tab kB     \tab \eqn{10^3}       \tab 1000 bytes    \cr
kibibyte  \tab binary  \tab KiB    \tab \eqn{2^{10}}     \tab 1024 bytes    \cr
megabyte  \tab decimal \tab MB     \tab \eqn{(10^3)^2}   \tab 1000 kilobytes\cr
mebibyte  \tab binary  \tab MiB    \tab \eqn{(2^{10})^2} \tab 1024 kibibytes\cr
gigabyte  \tab decimal \tab GB     \tab \eqn{(10^3)^3}   \tab 1000 megabytes\cr
gibibyte  \tab binary  \tab GiB    \tab \eqn{(2^{10})^3} \tab 1024 mebibytes\cr
terabyte  \tab decimal \tab TB     \tab \eqn{(10^3)^4}   \tab 1000 gigabytes\cr
tebibyte  \tab binary  \tab TiB    \tab \eqn{(2^{10})^4} \tab 1024 gibibytes\cr
petabyte  \tab decimal \tab PB     \tab \eqn{(10^3)^5}   \tab 1000 terabytes\cr
pebibyte  \tab binary  \tab PiB    \tab \eqn{(2^{10})^5} \tab 1024 tebibytes\cr
exabyte   \tab decimal \tab EB     \tab \eqn{(10^3)^6}   \tab 1000 petabytes\cr
exbibyte  \tab binary  \tab EiB    \tab \eqn{(2^{10})^6} \tab 1024 pebibytes\cr
zettabyte \tab decimal \tab ZB     \tab \eqn{(10^3)^7}   \tab 1000 exabytes\cr
zebibyte  \tab binary  \tab ZiB    \tab \eqn{(2^{10})^7} \tab 1024 exbibytes\cr
yottabyte \tab decimal \tab YB     \tab \eqn{(10^3)^8}   \tab 1000 zettabytes\cr
yebibyte  \tab binary  \tab YiB    \tab \eqn{(2^{10})^8} \tab 1024 zebibytes\cr
}

where Zi and Yi are GNU extensions to IEC. To get the output in the decimal
system (powers of 1000) use \code{standard="SI"}. To obtain IEC standard
(powers of 1024) use \code{standard="IEC"}.

In addition, single-character units are provided that follow (and
extend) the Unix pattern (use \code{standard="Unix"}):

\tabular{lrcll}{
Name      \tab System  \tab Symbol \tab Size             \tab Conversion    \cr
byte      \tab binary  \tab B      \tab \eqn{2^3}        \tab    8 bits     \cr
kibibyte  \tab binary  \tab K      \tab \eqn{2^{10}}     \tab 1024 bytes    \cr
mebibyte  \tab binary  \tab M      \tab \eqn{(2^{10})^2} \tab 1024 kibibytes\cr
gibibyte  \tab binary  \tab G      \tab \eqn{(2^{10})^3} \tab 1024 mebibytes\cr
tebibyte  \tab binary  \tab T      \tab \eqn{(2^{10})^4} \tab 1024 gibibytes\cr
pebibyte  \tab binary  \tab P      \tab \eqn{(2^{10})^5} \tab 1024 tebibytes\cr
exbibyte  \tab binary  \tab E      \tab \eqn{(2^{10})^6} \tab 1024 pebibytes\cr
zebibyte  \tab binary  \tab Z      \tab \eqn{(2^{10})^7} \tab 1024 exbibytes\cr
yottabyte \tab binary  \tab Y      \tab \eqn{(2^{10})^8} \tab 1024 zebibytes\cr
}

For printout both \code{digits} and \code{width} can be specified. If
\code{width} is \code{NULL}, all values have given number of digits. If
\code{width} is not \code{NULL}, output is rounded to a given width and
formated similar to human readable format of the Unix \code{ls},
\code{df} or \code{du} shell commands.

}

\references{

Wikipedia:
\url{http://en.wikipedia.org/wiki/Byte}
\url{http://en.wikipedia.org/wiki/SI_prefix}
\url{http://en.wikipedia.org/wiki/Binary_prefix}

GNU manual for coreutils:
\url{http://www.gnu.org/software/coreutils/manual/html_node/Block-size.html#Block-size}

}

\value{

Byte size in human readable format as character with proper unit symbols
added at the end of the string.

}

\author{Ales Korosec, Gregor Gorjanc, and Gregory R. Warnes
  \email{greg@warnes.net}}


\seealso{
  \code{\link{object.size}} in package 'gdata',
  \code{\link[utils]{object.size}} in package 'utils',
  \code{\link[gdata]{ll}}
}

\examples{

# Simple example: maximum addressible size of 32 bit pointer
humanReadable(2^32-1)
humanReadable(2^32-1, standard="IEC")
humanReadable(2^32-1, standard="SI")
humanReadable(2^32-1, standard="Unix")

humanReadable(2^32-1, unit="MiB")
humanReadable(2^32-1, standard="IEC",  unit="MiB")
humanReadable(2^32-1, standard="SI",   unit="MB")
humanReadable(2^32-1, standard="Unix", unit="M")

# Vector of sizes
matrix(humanReadable(c(60810, 124141, 124, 13412513), width=4))
matrix(humanReadable(c(60810, 124141, 124, 13412513), width=4, unit="KiB"))

# Specify digits rather than width
matrix(humanReadable(c(60810, 124141, 124, 13412513), width=NULL, digits=2))

# Change the justification
matrix(humanReadable(c(60810, 124141, 124, 13412513), width=NULL,
                    justify=c("right", "right") ))

}

\keyword{misc}

%--------------------------------------------------------------------------
% humanReadable.Rd ends here
