\name{elem}
\alias{elem}
\title{
  Display Information about Elements in a Given Object
}
\description{
  \emph{This function is depreciated.  Please use \code{\link{ll}}
    instead.}
  
  Display name, class, size, and dimensions of each element in a given
  object.
}
\usage{
elem(object=1, unit=c("KB","MB","bytes"), digits=0,
                 dimensions=FALSE)
}
\arguments{
  \item{object}{object containing named elements, perhaps a model or
    data frame.}
  \item{unit}{required unit for displaying element size: "KB", "MB",
    "bytes", or first letter.}
  \item{digits}{number of decimals to display when rounding element
    size.}
  \item{dimensions}{whether element dimensions should be returned.}
}
\details{
  A verbose alternative to \code{names()}.
}
\value{
  A data frame with named rows and the following columns:
  \item{Class}{element class.}
  \item{KB}{element size \emph{(see notes)}.}
  \item{Dim}{element dimensions \emph{(optional)}.}
}
\note{
  The name of the element size column is the same as the unit used.

  Elements of class \code{classRepresentation},
  \code{ClassUnionRepresentation}, and \code{grob} do not have a defined
  size, so 0 bytes are assumed for those.
}
\author{Arni Magnusson \email{arnima@u.washington.edu}}
\seealso{

  \code{\link[base]{names}}, \code{\link[utils]{str}}, and
  \code{\link[base]{summary}} display different information about object
  elements.

  \code{\link{ll}} and \code{\link{env}} are related to \code{elem}.
}
\examples{
\dontrun{
data(infert)
elem(infert)
model <- glm(case~spontaneous+induced, family=binomial, data=infert)
elem(model, dim=TRUE)
elem(model$family)
}
}
% Basics
\keyword{attribute}
\keyword{classes}
\keyword{list}
% Programming
\keyword{print}
\keyword{utilities}
