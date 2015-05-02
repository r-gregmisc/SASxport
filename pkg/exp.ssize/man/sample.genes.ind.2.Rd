\name{sample.genes.ind.2}
\alias{sample.genes.ind.2}

\title{Sample Observations (gene expressions) from Independent Normal 
       Distribution with Known sd}
\description{
   Sample observations (gene expressions) from independent normal 
   distribution for both control group and the treatment group with 
   known sd for control group and the variance ratio between
   treatment/control groups.
}
\usage{
sample.genes.ind.2(n, sd.ctrl, var.ratio, delta, distrn = "normal")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n}{positive integer number of replicates for each gene each group 
           (control/treatment)}
  \item{sd.ctrl}{ vector of positive numbers for the sample length as 
           ngenes.ind }
  \item{var.ratio}{ a positive number for the ratio of variance between 
           treatment and control}
  \item{delta}{ effect size for sample size calculation
           the minimum distance from zero for expression values of genes 
           coming from the true alternative hypothesis group}
  \item{distrn}{ distribution of expression data, set to be normal for here}
}
% \details{
%   ~~ If necessary, more details than the __description__  above ~~
% }
\value{
  returns a matrix with rows (the same length as sd.trl) and 2*n columns
  with the first n columns being samples from control group and last n 
  columns being from treatment group for each gene (row)
}
% \references{ ~put references to the literature/web site here ~ }

\author{ Peng Liu \email{peng\_liu@groton.pfizer.com}}
% \note{ ~~further notes~~ }

% ~Make other sections like Warning with \section{Warning }{....} ~

% \seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }

\examples{

sd.ctrl <- c(1:100)*0.01

test.sample1 <- sample.genes.ind.2(n = 20, sd.ctrl, var.ratio = 1, delta = 10)
}
\keyword{ datagen }
