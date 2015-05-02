`plotConverged_nocolor` <- function()
{
    oldpar <- par(no.readonly=TRUE)
    #par(mfrow=c(1,3))
    par(mfrow=c(3,1))
    par(mar=c(4, 3, 0.75, 0.75) + 0.1)

    maxY <- 0.0012
    
#    for (i in 1:8) {
    for (i in c(1,4)) {    
	p <- paste("d",i,sep="")
	plotDensity_nocolor(output12[,i],p,5000,Ylim=maxY,lineType=2)
	plotDensity_nocolor(output16[,i],p,5000,Ylim=maxY,lineType=3, add=TRUE)
	plotDensity_nocolor(output25[,i],p,5000,Ylim=maxY,lineType=4, add=TRUE)
    }
    # prior mode is 5, but fits are all much less than 5 so scale down so range
    # is [0,5]
    plotDensity_nocolor(output12[,9],'d9',5,Ylim=5.7,lineType=2, Xlim=5)
    plotDensity_nocolor(output16[,9],'d9',5,Ylim=5.7,lineType=3, Xlim=5, add=TRUE)
    plotDensity_nocolor(output25[,9],'d9',5,Ylim=5.7,lineType=4, Xlim=5, add=TRUE)

    par(oldpar)

  }

