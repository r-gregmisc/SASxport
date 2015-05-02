\name{ConvertMedUnits}
\alias{ConvertMedUnits}
\title{Convert medical measurements between International Standard (SI)
  and US 'Conventional' Units.}
\description{
  Convert Medical measurements between International Standard (SI)
  and US 'Conventional' Units.
}
\usage{
ConvertMedUnits(x, measurement, abbreviation,
                to = c("Conventional", "SI", "US"),
                exact = !missing(abbreviation))
}
\arguments{
  \item{x}{Vector of measurement values}
  \item{measurement}{Name of the measurement}
  \item{abbreviation}{Measurement abbreviation}
  \item{to}{Target units}
  \item{exact}{Logicial indicating whether matching should be exact}
}
\details{

  Medical laboratories and practitioners in the United States use one
  set of units (the so-called 'Conventional' units) for reporting the
  results of clinical laboratory measurements, while the rest of the
  world uses the International Standard (SI) units.  It often becomes
  necessary to translate between these units when participating in
  international collaborations.

  This function converts between SI and US 'Conventional' units.

  If \code{exact=FALSE}, \code{grep} will be used to do a
  case-insensitive sub-string search for matching measurement names.  If
  more than one match is found, an error will be generated, along with a
  list of the matching entries.
  
}
\value{
  Returns a vector of converted values.  The attribute 'units' will
  contain the target units converted.
}
\seealso{
  The data set \code{\link{MedUnits}} provides the conversion
  factors.
}
\references{
  \url{http://www.globalrph.com/conv_si.htm}
  }
\author{ Gregory R. Warnes \email{greg@warnes.net} }
\examples{
data(MedUnits)

# show available conversions
MedUnits$Measurement

# Convert SI Glucose measurement to 'Conventional' units
GlucoseSI = c(5, 5.4, 5, 5.1, 5.6, 5.1, 4.9, 5.2, 5.5) # in SI Units
GlucoseUS = ConvertMedUnits( GlucoseSI, "Glucose", to="US" )
cbind(GlucoseSI,GlucoseUS)

\dontrun{
# See what happens when there is more than one match
ConvertMedUnits( 27.5, "Creatin", to="US")
}

# To solve the problem do:
ConvertMedUnits( 27.5, "Creatinine", to="US", exact=TRUE)
}
\keyword{manip}
