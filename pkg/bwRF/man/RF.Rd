% $Id$

\name{RF}
\alias{RF}
\alias{print.RF}
\title{Fit a random forest}
\description{
  Fit a random forest
}
\usage{
RF(ycl, x, classwt=NULL, Vote=2, mtry=NULL, ntree=1000, ndsize=1,
   nbs=NULL, nreplace=TRUE, mreplace=FALSE, itest=FALSE, xts=0, nts=1,
   jints=0, nlook=0, iprox=FALSE, iimp=FALSE, ikeepft=FALSE, wGini=TRUE)
\method{print}{RF}(x, ...)
}
\arguments{
  \item{ycl}{class label for nsample}
  \item{x}{data matrix containing the training set (\code{RF}), or random
    forest object (\code{print.RF})}
  \item{classwt}{weight specified for different classes (used in tree
    construction)}
  \item{Vote}{method of tree voting (see details)}
  \item{mtry}{number of random features to try at each node split}
  \item{ntree}{number of trees to grow}
  \item{ndsize}{minimum terminal node size (1 will give a saturated
    tree, which has good performance)}
  \item{nbs}{size of Bootstrap sample set for each (bagging) tree}
  \item{nreplace}{Bootstrap samples with/without replacement}
  \item{mreplace}{Bootstrap features with/without replacement}
  \item{itest}{indicator testing set exists or not}
  \item{xts}{data matrix for testing set}
  \item{nts}{number of testing samples}
  \item{jints}{indicator for predicting which test subset [1:nts]}
  \item{nlook}{how often to look at the error}
  \item{iprox}{indicator of calculating proximity}
  \item{iimp}{indicator of calculating importance or not}
  \item{ikeepft}{indicator of keeping forest}
  \item{wGini}{?}
  \item{...}{Extra arguments for \code{print.RF}}

}
\details{
  The \code{vote} argument specifies the method of tree voting:
  \describe{
    \item{1}{simple vote, each tree counting 1}
    \item{2}{weighted vote using average sample weight of terminal node}
    \item{3}{probability vote (using proportions of winning class)}
  }
}
\value{
  A list containing
    \item{counttr}{OOB vote of all classes for each sample}
    \item{out}{total number of OOB vote for each sample}
    \item{countts}{vote matrix for testing set xts}
    \item{prox}{proximity matrix}
    \item{tmiss}{number of miss-classifications for each class}
    \item{tmissimp}{number of miss classifications for each class after
      permuting feature m [nclass, mdim] "a too gross measure; instead
      we can use posterior probability from countimp, is a continuous
      version of tmissimp"}
    \item{diffmarg}{total decrease of impurity (Gini, weighted or not) after permuting feature m}
    \item{used}{as an importance measure for each feature
      "derived from countimp, continuous version of tmissimp"
      \description{
	\item{marg}{posterior pr(true group) - max posterior pr(other group)}
        \item{diffmarg}{\sum marg(without permutation) - \sum marg(after
	  permutation)}
	\item{pp}{posterior pr(true group)}
      }
    }
    \item{diffpp}{= \sum pp(without permutation) - \sum pp(after permutation)
                               <==> diffmarg (if only two groups)}
    \item{minbgini}{(weighted) gini decrease for each feature using in-bag samples}
    \item{moobgini}{(weighted) gini decrease for each feature using out-of-bag samples}
    \item{wGini}{use weighted Gini decrease (default) or not}
    \item{treemap}{tree structure (parent-children chain)}
    \item{bestvar}{(best) split variable for each node}
    \item{xbestsplit}{(best) split value for the selected variable}
    \item{nodeclass}{class status for every node}
    \item{nodestatus}{terminal indicator for each node}
}
%\references{ ~put references to the literature/web site here ~ }
\author{Baolin Wu, R package by Gregory R. Warnes
  \email{warnes@bst.rochester.edu}}
%\note{ ~~further notes~~ }
%\seealso{ ~~objects to See Also as \code{\link{~~fun~~}}, ~~~ }
\examples{

##############
data(xytest)
jwt <- as.vector( rev(table(xytest$ycl)) ); jwt <- jwt/sum(jwt)
## mtry = 25
brf <- RF(xytest$ycl, xytest[,-1], classwt=jwt, ndsize=1, Vote=3,
            ## mtry=mtry,
            ntree=1000, nlook=170, iimp=FALSE, wGini=TRUE
            )

##### iris data
data(iris)
ycl <- as.numeric(iris[,5])-1
## ycl[ycl==2] <- 1
jwt <- as.vector( rev(table(ycl)) )
jwt <- prod(jwt)/jwt; jwt <- jwt/sum(jwt)
x <- iris[,-5]
irf <- RF(ycl, x, classwt=jwt, ndsize=5, Vote=3, ## mtry=mtry,
            ntree=5000, nlook=1100, iimp=TRUE, wGini=TRUE
            )

##### simulation
N0 <- 100; N1 <- 50; m0 <- 1000; m1 <- 10
ycl <- c( rep(0,N0),rep(1,N1) )
x1 <- matrix( rnorm(N0*m1, 0.75), N0, m1 )
x0 <- matrix( rnorm(N0*m0), N0, m0 )
x <- cbind(x1, x0)
x <- rbind(x, matrix(rnorm(N1*(m0+m1)), N1, m0+m1))
jwt <- 1:2
srf <- RF(ycl, x, classwt=jwt, ndsize=5, Vote=2,
            ntree=5000, nlook=1100, iimp=FALSE, wGini=TRUE
            )

## Vote=2: balance error rate
## Vote=1,3: no!!!

x0 <- x[, order(-srf$moob)[1:20]]
srf0 <- RF(ycl, x0, ndsize=5, Vote=3,
             ntree=5000, nlook=1100, iimp=FALSE, wGini=TRUE
             )

}
\keyword{ ~kwd1 }% at least one, from doc/KEYWORDS
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
