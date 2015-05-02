\name{installXLSXsupport}
\Rdversion{1.1}
\alias{installXLSXsupport}
\title{
Install perl modules needed for read.xls to support Excel 2007+ XLSX format
}
\description{
Install perl modules needed for read.xls to support Excel 2007+ XLSX format
}
\usage{
installXLSXsupport(perl = "perl", verbose = FALSE)
}
\arguments{
  \item{perl}{Path to perl interpreter (optional).}
  \item{verbose}{If \code{TRUE}, show additional messages during
    processing.}
}
\value{
  Either \code{TRUE} indicating that the necessary perl modules have
  been successfully installed, or \code{FALSE} indicating that an error
  has occured.
}
\details{

  This function calls the perl script 'install_modules.pl' located in
  the perl subdirectory of the gdata package directory (or inst/perl in
  the source package).  This perl script attempts to use the perl 'CPAN'
  package, which should be included as part of most perl installations,
  to automatically download, compile, and install the
  Compress::Raw::Zlib and Spreadsheet::XLSX perl modules needed for
  read.xls to support support Excel 2007+ XLSX files into the gdata
  perl subdirectory.

  Since the perl modules are installed into the gdata installation
  directory, the perl modules will be available until the gdata package
  is replaced or removed.  Since this occurs each time a new version of
  gdata is installed, \code{installXLSXsupport} will need to be run each
  time a new version of the gdata package is installed.

  Further, the binary Compress::Raw::Zlib package installed by
  \code{installXLSXsupport} is tied to the particular version of perl
  used to compile it, therefore, you will need to re-run
  \code{installXLSXsupport} if you install a different perl
  distribution.

  This installation process will fail if 1) perl is not available on the
  search path and the \code{perl} argument is not used to specify the
  path of the perl executable, 2) the perl installation is not properly
  configured for installing binary packages*, 3) if the CPAN module is
  not present, or 4) if the C compiler specified by the perl
  installation is   not present.

  \emph{In particular, \code{installXLSXsupport} will fail for the
  version of perl included with the current RTools.zip package, which is
  not correctly configured to allow installation of additional perl
  packages. (The RTools version of perl is installed in a different
  directory than the perl configuration files expect.)}

  The function \code{xlsFormats} can be used to see whether XLS and XLSX
  formats are supported by the currently available perl modules.
  }
\seealso{
	\code{\link{read.xls}}, \code{\link{xls2csv}}, \code{\link{xlsFormats}}
}
\examples{
\dontrun{
   installXLSXsupport()
}
}
\keyword{ misc }
