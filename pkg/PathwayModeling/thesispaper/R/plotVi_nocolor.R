`plotVi_nocolor` <-
function(Dsamp,input) {
#    attach(as.data.frame(input))
    times <- input[,1]
    CI <- get95CI(2,input,1,Dsamp)
    temp <- fitPaper(optimML,input)
    temp2 <- fitPaper(mcmcML,input)
    low <-min(CI,input[,3])
    high <- max(CI,input[,3])
    plot(times,input[,3],ylim=c(low,high),xlab="time",ylab="v2")
    lines(times, temp[[1]],  lty=1, lwd=3)
    lines(times, CI[,1],     lty=2, lwd=3)
    lines(times, CI[,2],     lty=2, lwd=3)
    lines(times, temp2[[1]], lty=3, lwd=3)
    abline(h=0)
    legend(32,2000,
           c("data",
             "maximum likelihood",
             "95% posterior credibile region",
             "maximum posterior density"),
           lty=c(0,1,2,3),
           lwd=3,
           pch=c(1,NA,NA,NA))
    for (i in 3:5) {
        CI <- get95CI(i,input,1,Dsamp)
        low <-min(CI,-400)
        high <- max(CI,800)
        plot(times,input[,i+1],ylim=c(low,high),
		xlab="time",ylab=paste("v",i,sep=""))
        lines(times, temp[[i-1]], lty=1, lwd=3, col="grey")
        lines(times, CI[,1],      lty=2, lwd=3)
        lines(times, CI[,2],      lty=2, lwd=3)
        lines(times, temp2[[i-1]],lty=3, lwd=3)
        abline(h=0)
    }
#    detach(as.data.frame(input))
}

