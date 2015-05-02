% $Id$
%
% $Log$
% Revision 1.9  2005/09/12 15:42:45  nj7w
% Updated Greg's email
%
% Revision 1.8  2005/06/09 14:20:25  nj7w
% Updating the version number, and various help files to synchronize splitting of gregmisc bundle in 4 individual components.
%
% Revision 1.1.1.1  2005/05/25 22:07:33  nj7w
% Initial entry for individual package gdata
%
% Revision 1.7  2004/04/01 20:23:15  warnes
% Add function remove.vars().
%
% Revision 1.6  2002/09/23 13:59:30  warnes
% - Modified all files to include CVS Id and Log tags.
%
%

\name{rename.vars}
\alias{rename.vars}
\alias{remove.vars}
\title{Remove or rename variables in a dataframe }
\description{
  Remove or rename a variables in a data frame.
}
\usage{
rename.vars(data, from="", to="", info=TRUE)
remove.vars(data, names="", info=TRUE)
}
\arguments{
  \item{data}{ dataframe to be modified.  }
  \item{from}{ character vector containing the current name of each
    variable to be renamed.}
  \item{to}{ character vector containing the new name of each variable
    to be renamed.}
  \item{names}{ character vector containing the names of variables to be
    removed.}
  \item{info}{ boolean value indicating whether to print details of the
    removal/renaming.  Defaults to TRUE.}
}
%\details{
%  ~~ If necessary, more details than the __description__  above ~~
%}
\value{
  The updated data frame with variables listed in \code{from} renamed to
  the corresponding element of \code{to}.
}
\author{Code by Don MacQueen \email{macq\@llnl.gov}.
  Documentation by Gregory R. Warnes
  \email{greg@warnes.net} }
\seealso{ \code{\link{names}},
  \code{\link{colnames}},
  \code{\link{data.frame}}
}

\examples{
data <- data.frame(x=1:10,y=1:10,z=1:10)
names(data)
data <- rename.vars(data, c("x","y","z"), c("first","second","third"))
names(data)

data <- remove.vars(data, "second")
names(data)
}
\keyword{ manip  }

