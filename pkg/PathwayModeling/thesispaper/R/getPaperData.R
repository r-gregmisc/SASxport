"getPaperData" <-
function(data,stepTime,times,npoints=3,varVector=rep(50,5)) {
    pre <- numeric()
    post <- numeric()
    step1<-dim(data[data[,1]<stepTime,])[1]
    step2 <- dim(data[data[,1] < (stepTime+0.01),])[1] + 1
    end<-dim(data)[1]
    R1a <- smooth.spline(data[1:step1,1], data[1:step1,2])
    R1b <- smooth.spline(data[step2:end,1], data[step2:end,2])
    R2a <- smooth.spline(data[1:step1,1], data[1:step1,3])
    R2b <- smooth.spline(data[step2:end,1], data[step2:end,3])
    R3a <- smooth.spline(data[1:step1,1], data[1:step1,4])
    R3b <- smooth.spline(data[step2:end,1], data[step2:end,4])
    R4a <- smooth.spline(data[1:step1,1], data[1:step1,5])
    R4b <- smooth.spline(data[step2:end,1], data[step2:end,5])
    R5a <- smooth.spline(data[1:step1,1], data[1:step1,6])
    R5b <- smooth.spline(data[step2:end,1], data[step2:end,6])
    answer <- matrix(0,nrow=length(times)*npoints,ncol=6)
    colnames(answer) <- c('Time','R1','R2','R3','R4','R5')
    for (i in 1:length(times)) {
	    if (times[i] < stepTime) pre <- c(pre,times[i])
	    if (times[i] > stepTime+0.01) post <- c(post,times[i])
    }
    for (i in 1:length(pre)) {
        temp <- c(predict(R1a,times[i])$y,
	          predict(R2a,times[i])$y,
		  predict(R3a,times[i])$y,
		  predict(R4a,times[i])$y,
		  predict(R5a,times[i])$y)
        for (j in 0:(npoints-1)) {
	    row <- i+j+(i-1)*(npoints-1)
	    answer[row,1] <- times[i]
	    for (k in 2:6) 
		answer[row,k] <- rnorm(1,temp[k-1],varVector[k-1])
	}
    }
    for (i in (length(pre)+1):length(times)) {
        temp <- c(predict(R1b,times[i])$y,
	          predict(R2b,times[i])$y,
		  predict(R3b,times[i])$y,
		  predict(R4b,times[i])$y,
		  predict(R5b,times[i])$y)
        for (j in 0:(npoints-1)) {
	    row <- i+j+(i-1)*(npoints-1)
	    answer[row,1] <- times[i]
	    for (k in 2:6) 
		answer[row,k] <- rnorm(1,temp[k-1],varVector[k-1])
	}
    }
    answer
}

