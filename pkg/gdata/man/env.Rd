\name{env}
\alias{env}
\title{Describe All Loaded Environments}
\description{
  Display name, number of objects, and size of all loaded environments.
}
\usage{
env(unit="KB", digits=0)
}
\arguments{
  \item{unit}{unit for displaying environment size: "bytes", "KB", "MB",
    or first letter.}
  \item{digits}{number of decimals to display when rounding environment
    size.}
}
\value{
  A data frame with the following columns:
  \item{Environment}{environment name.}
  \item{Objects}{number of objects in environment.}
  \item{KB}{environment size \emph{(see notes)}.}
}
\note{
  The name of the environment size column is the same as the unit used.
}
\author{Arni Magnusson}
\seealso{
  \code{env} is a verbose alternative to \code{\link{search}}.

  \code{\link{ll}} is a related function that describes objects in an
  environment.
}
\examples{
\dontrun{
env()
}
}
% Basics
\keyword{data}
% Programming
\keyword{environment}
\keyword{utilities}
