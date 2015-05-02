"getModes" <-
function(Data) {
    NC<-dim(Data)[2]
    answer<-numeric(NC)
    for (i in 1:NC) {
	temp1<-density(Data[,i])
	temp2<-data.frame(X=temp1$x,Y=temp1$y)
	answer[i]<-temp2[temp2[,2]==max(temp2[,2]),1]
    }
    answer
}

