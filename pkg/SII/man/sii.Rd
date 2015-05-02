\name{sii}
\alias{sii}
\alias{print.SII}
\alias{plot.SII}
\alias{summary.SII}
\title{Compute ANSI S3.5-1997 Speech Intelligibility Index (SII)}
\description{
  Compute the Speech Intelligibility Index (SII) described by ANSI
  specification S3.5-1997, including extensions for conductive
  hearing loss. Optionally apply interpolation obtain values for the
  required frequencies.
}
\usage{
sii(speech = c("normal", "raised", "loud", "shout"),
    noise, threshold, loss, freq, 
    method = c("critical", "equal-contributing",
               "one-third octave", "octave"),
    importance = c("SII", "NNS", "CID22", "NU6", "DRT",
                   "ShortPassage", "SPIN", "CST"),
    interpolate=FALSE)
\method{print}{SII}(x, digits=3, ...)
\method{plot}{SII}(x, ...)
\method{summary}{SII}(object, digits=2, ...)
}
\arguments{
  \item{speech}{Either a numeric vector providing \eqn{E'_i}{E'[i]}, the
    equivalent speech spectrum level (in dB) at each frequency, or a
    character string indicating the stated vocal effort corresponding to
    one of the standard standard speech spectrum levels ("normal",
    "raised", "loud", "shout"). Defaults to \code{speech="normal"}
    correspoding to the normal level of stated vocal effort. }
  \item{noise}{A numeric vector providing \eqn{N'_i}{N'[i]}, the
    equivalent noise spectrum level (in dB) at each frequency.  If
    missing, defaults to -50 dB for each frequency.}
  \item{threshold}{A numeric vector providing \eqn{T'_i}{T'[i]}, the
    equivalent hearing threshold level (in dB) at each frequency.  If
    missing, defaults to 0 dB for each frequency.}
  \item{loss}{A numeric vector providing \eqn{J'_i}{J'[i]}, the
    conductive hearing loss level (in dB) at each frequency.  If
    missing, defaults to 0 dB for each frequency.}
  \item{freq}{Vector of frequencies for which \code{speech},
    \code{noise}, \code{threshold}, and/or \code{loss} are specified.
    If \code{interpolate=TRUE}, \code{freq} must be specified.
    Otherwise, it must either match the required value for SII
    calculation method given by argument \code{method}, or be missing,
    in which case it will default to the values required for the
    specified method.}
  \item{method}{A character string specifying the SII calculation
    method ("critical", "one-third octave", "equal-contributing",
    "octave")}
  \item{importance}{Either a numeric vector providing \eqn{F_i}{F[i]},
    the transfer function (importance weights) at each frequency, or a
    character string indicating which transfer function to employ
    ("SII", "NNS", "CID22", "NU6", "DRT", "ShortPassage", "SPIN",
    "CST"). Defaults to the standard SII transfer function,
    \code{importance="SII"}.}
  \item{interpolate}{Logical flag indicating whether to interpolate 
    from the provide measurement values and frequencies to those 
    required by the specified method via linear interpolation on the log
    scale.}
  \item{object,x}{SII object}
  \item{digits}{Number of digits to display} 
  \item{...}{Optional arguments to \code{print}, \code{summary}, and
    \code{plot} methods} 
}
\details{
    American National Standard ANSI S3.5-1997 ("Methods for Calculation of
    the Speech Intelligibility Index") defines a method for computing a
    physical measure that is highly correlated with the intelligibility
    of speech as evaluated by speech perception tests given a group of
    talkers and listeners. This measure is called the Speech
    Intelligibility Index, or SII. The SII is calculated from acoustical
    measurements of speech and noise.

    The \code{sii} function implements ANSI S3.5-1997 as described in
    the standard, without any attempt to optimize the performance. The
    implementation does, however, include the extension for handling
    conductive hearing loss from Annex A (utilizing the optional
    \code{loss} argument), and for utilizing alternative band weights
    (i.e. transfer function) appropriate for differing message contents
    (e.g. types of speech) as described in Annex B or user-specified
    band weights (utilizing the optional argument \code{importance}).

    Further, this implementation provides a mechanism for
    interpolating/extrapolating available measurements to those required
    for the specified calculation procedure.  When
    \code{interpolate=TRUE}, required values for \code{speech},
    \code{noise}, \code{threshold}, and \code{loss} will be computed 
    using linear interpolation (of the log-scaled data).  In this case,
    missing values may be provided and will be appropriately
    interpolated.
}
\value{
    The return value is an object of class SII, containing the following
    components:
    \item{call}{Function call used to generate the SII object}
    \item{orig}{List containing original (pre-extrapolation) values for
      \code{freq}, \code{speech}, \code{noise}, \code{threshold}, and
      \code{loss}.}
    \item{speech, noise, threshold, loss, and freq}{Values used in
      calculations (extrapolated if necessary)}
    \item{table}{SII calculation worksheet, containing columns
      corresponding to both Table C.1 and C.2 in Annex C of the
      standard. Table columns are
      \describe{
	\item{Fi}{Center frequency of SII band, Hz}
	\item{E'i}{Spectrum level of equivalent speech, dB}
	\item{N'i}{Spectrum level of equivalent noise, dB}
	\item{T'i}{Equivalent hearing threshold level, dB}
	\item{Vi}{Spectrum level for self-speech masking, dB}
	\item{Bi}{Larger of the specrum levels for equivalent noise and
	  self-speech masking, dB}
	\item{Ci}{Slope per octave (doubling of frequency) of the upward
	  spread of masking, dB/octave}
	\item{Zi}{Spectrum level for equivalent masking, dB}
	\item{Xi}{Spectrum level of internal noise, dB}
	\item{X'i}{Spectrum level of equivalent internal noise, dB}
	\item{Di}{Spectrum level for equivalent disturbance, dB}
	\item{Ui}{Spectrum level of standard speech for normal vocal
	  effort, dB}
	\item{Ji}{Equivalent hearing threshold due to conductive hearing
	  loss, dB}
	\item{Li}{Speech level distortion factor, dB}
	\item{Ki}{Temporary variable used in the calculation of the band
	  auditability function}
	\item{Ai}{Band auditability function}
	\item{Ii}{Band importance function}
	\item{IiAi}{Product of the band importance function (Ii), and band
	  auditability function(Ai)}
      }
    }
    \item{sii}{Calculated SII value}
}
\references{
ANSI S3.5-1997, "American National Standard Methods for 
Calculation of the Speech Intelligibility Index" American National
Standards Institute, New York. 

Other software programs for calculating SII are available from
\url{http://www.sii.to/html/programs.html}.

}
\author{Gregory R. Warnes \email{greg@warnes.net}}
\seealso{ SII Constants: \code{\link{critical}}, and
  \code{\link{sic.critical}} }
\examples{

## Example C.1 from ANSI S3.5-1997 Annex C
sii.C1 <- sii(
              speech   = c(50.0, 40.0, 40.0, 30.0, 20.0,  0.0),
              noise    = c(70.0, 65.0, 45.0, 25.0,  1.0,-15.0),
              threshold= c( 0.0,  0.0,  0.0,  0.0,  0.0,  0.0),
              method="octave"
	      )
sii.C1                        # rounded to 2 digits by default
print(sii.C1$sii, digits=20)  # full precision
summary(sii.C1)               # full details
plot(sii.C1)                  # plot
## The value given in the Standard is $0.504$.


	      
## Same calculation, but manually specify the frequencies
## and importance function, and use default for threshold

sii.C1 <- sii(
              speech   = c(50.0, 40.0, 40.0, 30.0, 20.0,  0.0),
              noise    = c(70.0, 65.0, 45.0, 25.0,  1.0,-15.0),
              method="octave",
              freq=c(250, 500, 1000, 2000, 4000, 8000),
	      importance=c(0.0617, 0.1671, 0.2373, 0.2648, 0.2142, 0.0549)
	      )
sii.C1	     

## Now perform the calculation using frequency weights for the Connected
## Speech Test (CST)
sii.CST <- sii(
               speech   = c(50.0, 40.0, 40.0, 30.0, 20.0,  0.0),
               noise    = c(70.0, 65.0, 45.0, 25.0,  1.0,-15.0),
               method="octave",
	       importance="CST"
	      )
round(sii.CST$table[,-c(5:7,13)],2)
sii.CST$sii

## Example C.2 from ANSI S3.5-1997 Annex C

sii.C2 <- sii(
              speech   = rep(54.0, 18),
              noise    = c(40.0, 30.0, 20.0, rep(0, 18-3) ),
              threshold= rep(0.0,  18),
              method="one-third"
              )
sii.C2$table[1:3,1:8]
sii.C2

## Interpolation example, for 8 frequencies using NU6 importance
## weight, default values for noise.
sii.left <- sii(
                speech="raised",
                threshold=c(25,25,30,35,45,45,55,60),
                freq=c(250, 500, 1000, 2000, 3000, 4000, 6000, 8000),
                method="critical",
                importance="NU6",
                interpolate=TRUE
                )
sii.left


}

\keyword{math}

