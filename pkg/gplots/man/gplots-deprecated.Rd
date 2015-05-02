\name{gplots-deprecated}
\alias{deprecated}
\alias{smartlegend}
\title{Deprecated functions}
\description{
  These funcntion have been deprecated and will be removed in future
  releases of gplots.
}
\usage{
smartlegend(x = c("left", "center", "right"),
            y = c("top", "center", "bottom"),
            ...,
            inset = 0.05)
}
\arguments{
  \item{x, y, inset, \dots}{see man page for the corresponding replacement function}
}
\details{
These functions have been deprecated.  Please refer to the manual page
for the replacement function:
  \itemize{
    \item \code{smartlegend} is no longer needed because relative
    positioning has been implemented in graphics::legend().
  }
}
\author{Gregory R. Warnes \email{greg@warnes.net}}
\seealso{
  \code{\link{legend}},
  \code{\link[base]{Deprecated}}
}
\keyword{misc}
