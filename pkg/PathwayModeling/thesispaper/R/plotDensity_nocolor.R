`plotDensity_nocolor` <- function(data,
                                  parameter="di",
                                  prior,
                                  Ylim=0,
                                  Xlim=5*prior,
                                  lineType=1,
                                  add=FALSE
                                  )
  {
  
    dens<-density(data)
    deltaX<-(max(dens$x)-min(dens$x))/length(dens$x)
    sumY<-sum(dens$y)
    maxY<-max(dens$y, Ylim)
    X <- seq(0,Xlim, 0.05*prior)    

    if(!add)
      plot(X,
           3*dchisq(3*X/prior, 5)/prior,
           type='l',
           xlim=c(0,Xlim),
           ylim=c(0, maxY),
           ylab="density",
           xlab=parameter,
           lty=1, lwd=2)

    lines(dens$x, dens$y, lty=lineType, lwd=2)
  }

