\name{lsf.parRapply}
\alias{lsf.parRapply}
\alias{lsf.parCapply}
\alias{lsf.apply.model}
\title{Apply a function to each row/column of a matrix, using Rlsf for parallel
processing}

\description{
  Apply a funtion to each row/column of a matrix, using Rlsf for parallel
  processing
}
\usage{
lsf.parRapply(x, fun, ..., join.method=cbind, njobs,
              batch.size=getOption('lsf.block.size'), trace=TRUE,
              packages=NULL, savelist=NULL)

lsf.parCapply(x, ...)

lsf.apply.model(fun, matrix, ..., njobs,
                batch.size=getOption('lsf.block.size'),
                packages = .packages(), savelist = NULL)
}
\arguments{
  \item{x,matrix}{Data matrix}
  \item{fun}{Function to apply to each row of \code{x}}
  \item{\dots}{Additional arguments to \code{fun}}
  \item{join.method}{Funtion used to join together results from each
    parallel job.  **Note: When \code{fun} returns a vector, this needs
    to be a function that operates on the transpose of the matrix.}
  \item{njobs}{Number of parallel jobs to use.}
  \item{batch.size}{Number of rows to include in each parallel
    job. Defaults to the value of options('lsf.block.size').}
  \item{trace}{Show progress of computational jobs.}
  \item{packages}{List of library packages to be loaded by each worker
    process before computation is started.}
  \item{savelist}{Chacacter vector giving the names of local objects
    that should be copied to each worker process before computation is
    started.}
}
\details{

  \code{lsf.parRapply} applies the supplied function to each row of the
  supplied matrix \code{x}. \code{lsf.parCapply} does the same for
  columnms.  \code{lsf.apply.model} is a wrapper around
  \code{lsf.parRapply} that does some extra error checking, has better
  handling of warnings, and transposes the output to match users's
  expectations.
  
  
  The arguments  \code{batch.size} and \code{njobs} are mutually
  exclusive.  If \code{batch.size} is set, the data matrix \code{x} into
  sections of size \code{batch.size}.  The number of sections will
  determine the number of jobs.

  On the other hand, if \code{numjobs} is set, the data matrix \code{x}
  will be divided into \code{numbjobs} components of near equal size.

  The arguments \code{packages} and \code{savelist} can be used to
  properly initialize the worker processes.
}
\value{
  A matrix,  vector, or list (depending on the value of 'join.method')
  containing the result of applying \code{fun} to each row of the matrix
  \code{x}.  As each call to \code{fun} is wrapped in a \code{try}
  statement, the returned object may contain \code{try-error} objects.
}
\author{ Gregory R. Warnes \email{warnes@bst.rochester.edu}}
\seealso{ \code{\link[Rlsf]{lsf.apply.model}}, \code{\link[Rlsf]{lsf.submit}} }
\examples{

   #####
   ## Example of lsf.parRapply
   #####
   set.seed(12345)
   x <- matrix(rnorm(1e6+20),ncol=20)
   dim(x)
   means <- lsf.parRapply(x, mean, na.rm=TRUE, join.method=c, njobs=20)
   means <- lsf.parRapply(x, mean, na.rm=TRUE, join.method=c, batch.size=1000)

   ####
   ## Example of lsf.apply,model
   ####
   library(Rlsf)
   library(gdata);

   # generate an example data set
   set.seed(1)
   age <- rnorm(200,40,12)
   sex <- factor(sample(c('female','male'),200,TRUE))
   logit <- (sex=='male') + (age-40)/5
   y <- ifelse(runif(200) <= plogis(logit), 1, 0)
   dataframe <- data.frame(age=age, sex=sex)

   # create a matrix made up of rows containing the y data
   ymat <- matrix(y, nrow=30127, ncol=length(y), byrow=TRUE)

   # define the model fitting function
   fun <- function(y, covariates)
     {

       fit <- lm( y ~ age*sex, data=covariates )
       sum <- summary(fit)
       retval <- unmatrix( coef(sum) )
       retval
     }
   
   # now fit the model to each row (will yield identical results for each...)
   ret <- lsf.apply.model (
                           fun,
                           matrix = ymat,
                           covariates = dataframe,
                           savelist="unmatrix",
                           batch.size=3000
                         )



}
\keyword{utilities}
