`plotDensities_nocolor` <-
function(output) {
    for (i in 1:9) {
	low <- modes[i]-5*SD[i]
	high <- modes[i]+5*SD[i]
	step <- (high-low)/100
        hist(output[,i],breaks=30,xlim=c(low,high),xlab=paste("d",i,sep=""),main="")
        par(new=T)
        plot(seq(low,high,step),dnorm(seq(low,high,step),modes[i],SD[i]),type='l',            xlim=c(low,high),xlab="",yaxt='n',ylab="")
	abline(v=mcmcML[i], lty=2, lwd=4)
    }
}

