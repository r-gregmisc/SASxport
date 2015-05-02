"get95CI" <-
function(reaction,input,npoints,Dsamp) {
    L <- dim(input)[1]/npoints
    temp1 <- input[,-(2:6)]
    temp2 <- matrix(0,L,6)
    colnames(temp2) <- colnames(temp1)
    for (i in 1:L)
	temp2[i,] <- mean(temp1[(npoints*i-(npoints-1)):(npoints*i),])
#    attach(as.data.frame(temp2))
    M <- dim(Dsamp)[1]
    temp3 <- matrix(0,nrow=M,ncol=L)
    answer <- matrix(0,L,2)
    fitPaper <- function(D) {
        a1 <- (D[1]*R1/(D[2]+R1))
        a2 <- (D[3]*R2/(D[4]+R2))
        a3 <- (D[5]*R3/(D[6]+R3))
        a4 <- (D[7]*R4/(D[8]+R4))
        a5 <- D[9]*R5

        v2 <- a1 - a2
        v3 <- a2 - a3
        v4 <- a3 - a4
        v5 <- a4 - a5
    
    list(v2=v2,v3=v3,v4=v4,v5=v5)
    }
    for (i in 1:M)
        temp3[i,] <- fitPaper(Dsamp[i,])[[reaction-1]]
    for (i in 1:L) {
	answer[i,1] <- min(temp3[,i])
	answer[i,2] <- max(temp3[,i])
    }
#    detach(as.data.frame(temp2))
    answer
}

