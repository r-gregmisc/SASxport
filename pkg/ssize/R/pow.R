#####
# Power
#####

pow<-function(sd, n, delta, sig.level, alpha.correct="Bonferonni")
{
  ntest <- length(sd)

  if(length(delta)==1) delta <- rep(delta,ntest)

  if(alpha.correct=="Bonferonni")
    alpha <- sig.level/ntest
  else
    alpha <- sig.level
  
  retval<-rep(NA, ntest)     #
  names(retval)<-names(sd)   #
  for(i in 1:ntest)          # can be replaced with an sapply
  {
    if(i%%10==0) cat(".")
      try(
          retval[i]<-power.t.test(n=n,
                                  delta=delta[i],
                                  sd=sd[i],
                                  sig.level=alpha, 
                                  power=NULL,
                                  type="two.sample",
                                  alternative="two.sided")$power
          )
  }   

  retval
}




power.plot <- function(x,
                       xlab="Power",
                       ylab="Proportion of Genes with Power >= x",
                       marks=c(0.70,0.80,0.90),
                       ...)
  {
    n <- nobs(x)
    inv <- list()
    inv$x <- sort(x)
    inv$y <- ecdf(x)(inv$x)
    inv$y <- 1 - inv$y
    plot(inv, type="s",
         xlab=xlab, ylab=ylab, yaxt="n",
         ..., )
    vals <- pretty(inv$y * n)
    labels <- paste( format(vals/n*100,digits=2), "%=", vals, sep='')
    axis(side=2, at=vals/n, labels=labels, srt=90, adj=0.5)
    if(!is.null(marks) && length(marks)>0 )
      {
        xmin <- par("usr")[1]
        ymin <- par("usr")[3]
        
        for(mark in marks)
          {
            y <- inv$y[ which(inv$x>mark)[1]-1 ]
            lines( x=rbind( c(mark, ymin),
                            c(mark, y) ),
                   lty=2, col='red' )
            text( x=mark, y=ymin, label=format(mark,2), col="red", adj=c(0,0))
            lines( x=rbind( c(xmin, y),
                            c(mark, y) ),
                   lty=2, col='red' )
            text( x=xmin, y=y,
                 label=paste(format(y*100,digits=2),"%=",
                             format(y*n,digits=2), sep=''),
                 col="red", adj=c(0,0), xpd=TRUE)
          }
      }
  }
