"pulse" <-
function() {
plot(Time,R1,ylim=c(0,8000),ylab="# molecules",type='l',col=1,lty=1,lwd=2)
par(new=T)
plot(Time,R2,ylim=c(0,8000),ylab="",type='l',col=2,lty=2,lwd=2)
par(new=T)
plot(Time,R3,ylim=c(0,8000),ylab="",type='l',col=3,lty=3,lwd=2)
par(new=T)
plot(Time,R4,ylim=c(0,8000),ylab="",type='l',col=4,lty=4,lwd=2)
par(new=T)
plot(Time,R5,ylim=c(0,8000),ylab="",type='l',col=6,lty=5,lwd=2)
abline(v=20,lty=2)
legend(35,7800,c("R1","R2","R3","R4","R5"),col=c(1:4,6),lty=1:5,lwd=2)
}

