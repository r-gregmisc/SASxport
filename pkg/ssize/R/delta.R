delta<-function(sd, n, power, sig.level, alpha.correct="Bonferonni")
{
  ntest <- length(sd)

  if(length(power==1)) power <- rep(power,ntest)

  if(alpha.correct=="Bonferonni")
    alpha <- sig.level/ntest
  else
    alpha <- sig.level
  
  retval<-rep(NA, ntest)
  names(retval)<-names(sd)
  for(i in 1:ntest)
  {
    if(i%%10==0) cat(".")
      try(
          retval[i]<-power.t.test(n=n,
                                  delta=NULL,
                                  sd=sd[i],
                                  sig.level=alpha, 
                                  power=power[i],
                                  type="two.sample",
                                  alternative="two.sided")$delta
          )
  }   

  2^retval
}




delta.plot <- function(x,
                       xlab="Fold Change",
                       ylab="Proportion of Genes with Power >= 80% at Fold Change=delta",
                       marks=c(1.5, 2.0, 2.5, 3.0, 4.0, 6.0,10),
                       ...)
  {
    n <- nobs(x)
    inv <- list()
    inv$x <- sort(x)
    inv$y <- ecdf(x)(inv$x)
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
