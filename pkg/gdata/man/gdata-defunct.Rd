\name{gdata-defunct}
\alias{aggregate.table}
\title{Defunct Functions in Package 'gdata'}
\description{
  The functions or variables listed here are no longer part of 'gdata'.
}
\usage{
aggregate.table(x, by1, by2, FUN=mean, ...)
}
%- maybe also `usage' for other objects documented here.
\arguments{
  \item{x}{ data to be summarized }
  \item{by1}{ first grouping factor.  }
  \item{by2}{ second grouping factor. }
  \item{FUN}{ a scalar function to compute the summary statistics which can
          be applied to all data subsets. Defaults to \code{mean}.}
  \item{\dots}{ Optional arguments for \code{FUN}. }
}
\details{
  \code{aggregate.table(x, by1, by2, FUN=mean, ...)} should be replacede
  by \code{tapply(X=x, INDEX=list(by1, by2), FUN=FUN, ...)}.
}


