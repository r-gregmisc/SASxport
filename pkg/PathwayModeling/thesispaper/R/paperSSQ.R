"paperSSQ" <-
function(D) {
    D <- as.numeric(D)
    npoints<-length(R1)
    v2.SSQ<-0
    v3.SSQ<-0
    v4.SSQ<-0
    v5.SSQ<-0

    a1 <- (D[1]*R1/(D[2]+R1))
    a2 <- (D[3]*R2/(D[4]+R2))
    a3 <- (D[5]*R3/(D[6]+R3))
    a4 <- (D[7]*R4/(D[8]+R4))
    a5 <- D[9]*R5

    V2 <- a1 - a2
    V3 <- a2 - a3
    V4 <- a3 - a4
    V5 <- a4 - a5

    for (i in 1:npoints) {
	v2.SSQ <- v2.SSQ + (v2[i] - V2[i])^2
	v3.SSQ <- v3.SSQ + (v3[i] - V3[i])^2
	v4.SSQ <- v4.SSQ + (v4[i] - V4[i])^2
	v5.SSQ <- v5.SSQ + (v5[i] - V5[i])^2
    }
    (v2.SSQ + v3.SSQ + v4.SSQ + v5.SSQ)/(length(R1)*4)
}

