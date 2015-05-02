####
# Sample Size
####

ssize<-function(sd, delta, sig.level, power, alpha.correct="Bonferonni")
{
  ntest <- length(sd)

  if(length(delta==1)) delta <- rep(delta,ntest)

  if(alpha.correct=="Bonferonni")
    alpha <- sig.level/ntest
  else
    alpha <- sig.level

  retval <- vector(length=ntest)
  names(retval) <- names(sd)
  
  for(i in 1:ntest)
  {
    if(i%%10==0) cat(".")
      try(
          retval[i]<-power.t.test(n=NULL, delta=delta[i], sd=sd[i],
                                  sig.level=alpha, 
                                  power=power,
                                  type="two.sample",
                                  alternative="two.sided")$n
          )
  }   


  
  retval
}


ssize.plot <- function(x,
                       xlab="Sample Size (per group)",
                       ylab="Proportion of Genes Needing Sample Size <= n",
                       marks=c(2,3,4,5,6,8,10,20),
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

    xmax <- par("usr")[2]
    ymax <- par("usr")[4]

    if(!is.null(marks))
      {
        xmin <- par("usr")[1]
        ymin <- par("usr")[3]
        
        for(mark in marks)
          {
            if(mark < min(inv$x) || mark > max(inv$x))
              next
            else
              y <- inv$y[ which(inv$x>mark)[1]-1 ]

            lines( x=rbind( c(mark, ymin),
                            c(mark, y) ),
                   lty=2, col='red' )
            text( x=mark, y=ymin, label=format(mark,2), col="red", adj=c(0,0))
            lines( x=rbind( c(xmin, y),
                            c(mark, y) ),
                   lty=2, col='red' )
            text( x=xmin, y=y,
                 label=paste(format(y*100,digits=2),"%=", y*nobs(x), sep=''),
                 col="red", adj=c(0,0), xpd=TRUE)
          }
      }
  }

