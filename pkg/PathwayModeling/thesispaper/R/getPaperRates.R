"getPaperRates" <-
function(data,part1,part2) {
    times <- data[,1]
    R1a <- smooth.spline(data[part1,1], data[part1,2])
    R1b <- smooth.spline(data[part2,1], data[part2,2])
    R2a <- smooth.spline(data[part1,1], data[part1,3])
    R2b <- smooth.spline(data[part2,1], data[part2,3])
    R3a <- smooth.spline(data[part1,1], data[part1,4])
    R3b <- smooth.spline(data[part2,1], data[part2,4])
    R4a <- smooth.spline(data[part1,1], data[part1,5])
    R4b <- smooth.spline(data[part2,1], data[part2,5])
    R5a <- smooth.spline(data[part1,1], data[part1,6])
    R5b <- smooth.spline(data[part2,1], data[part2,6])
    answer <- matrix(0,nrow=length(times),ncol=6)
    colnames(answer) <- c('Time','v1','v2','v3','v4','v5')
    for (i in 1:length(part1)) {
        temp <- c(predict(R1a,times[i],deriv=1)$y,
	          predict(R2a,times[i],deriv=1)$y,
		  predict(R3a,times[i],deriv=1)$y,
		  predict(R4a,times[i],deriv=1)$y,
		  predict(R5a,times[i],deriv=1)$y)
	answer[i,1] <- times[i]
	for (j in 2:6) answer[i,j] <- temp[j-1]
    }
    for (i in (length(part1)+1):dim(data)[1]) {
        temp <- c(predict(R1b,times[i],deriv=1)$y,
	          predict(R2b,times[i],deriv=1)$y,
		  predict(R3b,times[i],deriv=1)$y,
		  predict(R4b,times[i],deriv=1)$y,
		  predict(R5b,times[i],deriv=1)$y)
	answer[i,1] <- times[i]
	for (j in 2:6) 
	    answer[i,j] <- temp[j-1]
    }
    cbind(answer,data[,-1])
}

