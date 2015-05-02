\name{xlsFormats}
\Rdversion{1.1}
\alias{xlsFormats}
\title{
Check which file formats are supported by read.xls
}
\description{
Check which file formats are supported by read.xls
}
\usage{
xlsFormats(perl = "perl", verbose = FALSE)
}
\arguments{
  \item{perl}{Path to perl interpreter (optional).}
  \item{verbose}{If \code{TRUE}, show additional messages during
    processing.}
}
\value{
  Vector of supported formats, possible elements are 'XLS' and 'XLSX'.
}

\seealso{
	\code{\link{read.xls}}, \code{\link{xls2csv}}.
}
\examples{
   xlsFormats()
}
\keyword{ misc }
