`plotMSD16_nocolor` <-
function () {
#    cat("finding temp1...\n")
#    temp1 <- getMSDvsEvals(OneComp.MSD.dat,20,250)
#    cat("finding temp2...\n")
#    temp2 <- getMSDvsEvals(AllComp.MSD.dat,20,1)
#    cat("finding temp3...\n")
#    temp3 <- getMSDvsEvals(NKC.MSD.dat1,2,20)
#    for (i in 2:10) {
#        file <- sub('#',as.character(i),'NKC.MSD.dat#')
#	temp3 <- temp3 + getMSDvsEvals(eval(as.name(file)),2,20)
#    }
#    temp3 <- temp3/10
    ymax <- max(temp1[,2],temp2[,2],temp3[,2])
    plot(temp1[,1], temp1[,2], type='l', log="x", ylim=c(5000,ymax), xlim=c(1,10^7),
         xlab="#evals", ylab="mean squared residual", lwd=3)
    lines(temp2[,1],temp2[,2], lty=2, lwd=3)
    lines(temp3[,1],temp3[,2], lty=3, lwd=3)
    legend(10^4.5,ymax,c("1-comp","all-comp","NKC"),lty=1:3, lwd=3)
}

