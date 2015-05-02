\name{critical}
\alias{critical}
\alias{equal}
\alias{onethird}
\alias{octave}
\alias{overall.spl}
\docType{data}
\title{Constants Tables for ANSI S3.5-1997 Speech Intelligibility Index
  (SII)} 
\description{
  Tables of constants for ANSI S3.5-1997 Speech Intelligibility Index
  (SII) 
}
\usage{
data(critical)
data(equal)
data(onethird)
data(octave)
data(overall.spl)
}

\format{
  Each data frames has 6-21 observations and a subset of the following
  variables: 
  \describe{
    \item{\code{fi}}{Center frequency of SII band, Hz}
    \item{\code{li}}{Lower limit of frequency band, Hz}
    \item{\code{hi}}{Upper limit of frequency band, Hz}
    \item{\code{Deltai}}{Band width adjustment, dB}
    \item{\code{Ii}}{Band importance function}
    \item{\code{normal}, \code{raised}, \code{loud} and
      \code{shout}}{Standard spectrum levels for vocal effort levels
      "normal", "raised", "loud", and "shout", respectively, dB}
    \item{\code{Xi}}{Spectrum level of internal noise, dB}
    \item{\code{Fi}}{Band importance function (weight)}
  }
}
\details{
  These data objects provide constant tables 1 -- 4 from the ANSI
  S3.5-1997.
  \describe{
    \item{\code{critical}}{Table 1: Critical band SII procedure
      constants} 
    \item{\code{equal}}{Table 2:Equally contributing (17 band) critical
      band SII} 
    \item{\code{onethird}}{Table 3: One-third octave band SII procedure
      constants}
    \item{\code{octave}}{Table 4: Octave band SII procedure constants}
    \item{\code{overall.spl}}{Overall sound pressure level (SPL) for the
      for  vocal effort levels "normal", "raised", "loud", and "shout",
      in dB}
    }
}
\source{
ANSI S3.5-1997, "American National Standard Methods for 
Calculation of the Speech Intelligibility Index" American National
Standards Institute, New York. 
}
\references{
ANSI S3.5-1997, "American National Standard Methods for 
Calculation of the Speech Intelligibility Index" American National
Standards Institute, New York. 
}
\examples{
data(critical)
critical # show entire table

data(equal)
names(equal)
equal$fi # extract just the frequency band centers

data(onethird)
barplot(onethird$Ii) # plot band importance function (weights)

data(octave)
round(octave, digits=2) # just 2 digits

data(overall.spl)
overall.spl
}
\keyword{datasets}
