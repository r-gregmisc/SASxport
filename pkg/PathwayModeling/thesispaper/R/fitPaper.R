"fitPaper" <-
function(D,input) {
#    attach(as.data.frame(input))
	
    a1 <- (D[1]*R1/(D[2]+R1))
    a2 <- (D[3]*R2/(D[4]+R2))
    a3 <- (D[5]*R3/(D[6]+R3))
    a4 <- (D[7]*R4/(D[8]+R4))
    a5 <- D[9]*R5

    v2 <- a1 - a2
    v3 <- a2 - a3
    v4 <- a3 - a4
    v5 <- a4 - a5
    
#    detach(as.data.frame(input))
    list(v2=v2,v3=v3,v4=v4,v5=v5)
}

