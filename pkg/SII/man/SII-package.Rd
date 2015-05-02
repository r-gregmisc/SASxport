\name{SII-package}
\alias{SII-package}
\alias{SII}
\docType{package}
\title{
  Calculate ANSI S3.5-1997 Speech Intelligibility Index
}
\description{
   This package calculates ANSI S3.5-1997 Speech Intelligibility Index
   (SII), a standard method for computing the intelligibility of
   speech from acoustical measurements of speech, noise, and hearing
   thresholds. This package includes data frames corresponding to
   Tables 1 - 4 in the ANSI standard as well as a function utilizing
   these tables and user-provided hearing threshold and noise level
   measurements to compute the SII score.  The methods implemented
   here extend the standard computations to allow calculation of SII
   when the measured frequencies do not match those required by the
   standard by applying interpolation to obtain values for the
   required frequencies.
}
\author{
  Gregory R. Warnes \email{greg@warnes.net}
}
\references{
ANSI S3.5-1997, "American National Standard Methods for 
Calculation of the Speech Intelligibility Index" American National Stan- 
dards Institute, New York.

Other software programs for calculating SII are available from
\url{http://www.sii.to/html/programs.html}.
}
\keyword{ package }
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
}
