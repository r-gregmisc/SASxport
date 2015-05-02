"plotConverged" <-
function() {
    maxY <- 0.0012
    for (i in 1:8) {
	p <- paste("d",i,sep="")
	plotDensity(output12[,i],p,5000,Ylim=maxY,color=2,lineType=2)
	par(new=T)
	plotDensity(output16[,i],p,5000,Ylim=maxY,color=3,lineType=3)
	par(new=T)
	plotDensity(output25[,i],p,5000,Ylim=maxY,color=4,lineType=4)
    }
    plotDensity(output12[,9],'d9',5,Ylim=5.7,color=2,lineType=2)
    par(new=T)
    plotDensity(output16[,9],'d9',5,Ylim=5.7,color=3,lineType=3)
    par(new=T)
    plotDensity(output25[,9],'d9',5,Ylim=5.7,color=4,lineType=4)
}

