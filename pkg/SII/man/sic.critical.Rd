\name{sic.critical}
\alias{sic.critical}
\alias{sic.onethird}
\alias{sic.octave}
\docType{data}
\title{Alternative ANSI S3.5-1997 SII Transfer Function Weights}
\description{
  Alternative ANSI S3.5-1997 Speech Intelligibility Index (SII) transfer
  function weights for for various types of speech material.
}
\usage{
data(sic.critical)
data(sic.onethird)
data(sic.octave)
}
\format{
  Each data frame  contains the following 8 variables, each
  corresponding the the transfer function weights for a specific type of
  speech material:
  \describe{
    \item{\code{fi}}{Center frequency, Hz}
    \item{\code{SII}}{Standard SII transfer function (weights)}
    \item{\code{NNS}}{NNS (various nonsense syllable tests where
      most of the English phonems occur equally often)}
    \item{\code{CID22}}{CID-W22 (PB-words)}
    \item{\code{NU6}}{NU6 monosyllables}
    \item{\code{DRT}}{DRT (Diagnostic Rhyme Test)}
    \item{\code{ShortPassage}}{short passages of easy reading material}
    \item{\code{SPIN}}{SPIN monosyllables}
    \item{\code{CST}}{Connected Speech Test}
  }
}
\details{
  \describe{
    \item{\code{sic.critical}}{provides alternative weights for the
      critical band SII procedure.}
    \item{\code{sic.threeoctave}}{provides alternative weights for the
      one-third octave frequency band SII procedure.}
    \item{\code{octave}}{provides alternative weights for the
      octave frequency band SII procedure.}
  }
}
\section{note}{There is no table of alternative weights for the
  equally-weighted SII band procedure as the weights for this method are
  (by definition) constant across all bands.
  }
\source{
  All values except the \code{CST} columns are from:

  ANSI S3.5-1997, "American National Standard Methods for 
  Calculation of the Speech Intelligibility Index" American National
  Standards Institute, New York. 

  Values in the \code{CST} columns are from:
  \url{http://www.sii.to/CSTdata.txt}
}
\references{
  ANSI S3.5-1997, "American National Standard Methods for 
  Calculation of the Speech Intelligibility Index" American National
  Standards Institute, New York. 
}
\examples{
## Load the alternative weights for the critical band method
data(sic.critical)

## display the weights
round(sic.critical,3)

## draw a comparison plot
ngroup <- ncol(sic.critical)
matplot(x=sic.critical[,1], y=sic.critical[,-1],
        type="o",
        xlab="Frequency, Hz",
        ylab="Weight",
        log="x",
        lty=1:ngroup,
        col=rainbow(ngroup)
)
legend(
       "topright",
       legend=names(sic.critical)[-1],
       pch=as.character(1:ngroup),
       lty=1:ngroup,
       col=rainbow(ngroup)
       )

data(threeoctave)
data(octave)
}
\keyword{datasets}
