"plotDensity" <-
function(data,parameter="di",prior,Ylim=0,color=1,lineType=1) {
    dens<-density(data)
    deltaX<-(max(dens$x)-min(dens$x))/length(dens$x)
    sumY<-sum(dens$y)
    maxY<-max(dens$y, Ylim)
    X<-seq(1,5*prior,0.05*prior)
    plot(X,3*dchisq(3*X/prior,5)/prior,type='l',xlim=c(0,5*prior),ylim=c(0,maxY),ylab="density",xlab=parameter,lty=1)
    par(new=T)
    plot(dens$x,dens$y,xlim=c(0,5*prior),ylim=c(0,maxY),type='l',col=color,ylab="",xlab="",lty=lineType)
}

