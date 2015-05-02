"getMSDvsEvals" <-
function(data,interval,thinning) {
    NC <- dim(data)[2]
    NR <- dim(data)[1]
    answer <- matrix(0,nrow=NR%/%interval+1,ncol=2)
    colnames(answer) <- c("nEvals","MSD")
    MSD <- 0
    start <- c(4891,4707,5298,7192,3571,6509,4254,4585,2)
    answer[1,1] <- 1
    answer[1,2] <- paperSSQ(start)
    for (i in 1:NR) {
	MSD <- MSD + paperSSQ(data[i,])
	if (i%%interval == 1 || interval == 1) {
	    answer[(i%/%interval)+2,1] <- i*thinning
	    answer[(i%/%interval)+2,2] <- MSD/i
	}
    }
    answer
}

