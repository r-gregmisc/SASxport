\name{MedUnits}
\alias{MedUnits}
\docType{data}
\title{
  Table of conversions between Intertional
  Standard (SI) and US 'Conventional' Units for common medical
  measurements.
}
\description{
  Table of conversions between Intertional
  Standard (SI) and US 'Conventional' Units for common medical
  measurements.
}
\usage{data(MedUnits)}
\format{
  A data frame with the following 5 variables.
  \describe{
    \item{Abbreviation}{Common Abbreviation (mostly missing)}
    \item{Measurement}{Measurement Name}
    \item{ConventionalUnit}{Conventional Unit}
    \item{Conversion}{Conversion factor}
    \item{SIUnit}{SI Unit}
  }
}
\details{

  Medical laboratories and practitioners in the United States use one
  set of units (the so-called 'Conventional' units) for reporting the
  results of clinical laboratory measurements, while the rest of the
  world uses the International Standard (SI) units.  It often becomes
  necessary to translate between these units when participating in
  international collaborations.

  This data set provides constants for converting between SI and
  US 'Conventional' units.

  To perform the conversion from SI units to US 'Conventional' units do:

     Measurement in \code{ConventionalUnit} =
     (Measurement in \code{SIUnit}) /  \code{Conversion}

  To perform conversion from 'Conventional' to SI units do:

     Measurement in \code{SIUnit} =
     (Measurement in \code{ConventionalUnit}) * \code{Conversion}

}
\source{
  \url{http://www.globalrph.com/conv_si.htm}
}
\seealso{
  The function \code{\link{ConvertMedUnits}} automates the
  conversion task.
}
\examples{

data(MedUnits)

# show available conversions
MedUnits$Measurement

# utility function
matchUnits <- function(X) MedUnits[ grep(X, MedUnits$Measurement),]

# Convert SI Glucose measurement to 'Conventional' units
GlucoseSI = c(5, 5.4, 5, 5.1, 5.6, 5.1, 4.9, 5.2, 5.5) # in SI Units
GlucoseUS = GlucoseSI / matchUnits("Glucose")$Conversion 
cbind(GlucoseSI,GlucoseUS)

# also consider using ConvertMedUnits()
ConvertMedUnits( GlucoseSI, "Glucose", to="US" )
}
\keyword{datasets}
