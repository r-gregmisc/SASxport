`pulse_nocolor` <-
function() {
plot(Time,R1,ylim=c(0,8000),ylab="# molecules",type='l',lty=1,lwd=2)
par(new=T)
plot(Time,R2,ylim=c(0,8000),ylab="",type='l',lty=2,lwd=2)
par(new=T)
plot(Time,R3,ylim=c(0,8000),ylab="",type='l',lty=3,lwd=2)
par(new=T)
plot(Time,R4,ylim=c(0,8000),ylab="",type='l',lty=4,lwd=2)
par(new=T)
plot(Time,R5,ylim=c(0,8000),ylab="",type='l',lty=5,lwd=2)
abline(v=20,lty=2)
legend(35,7800,c("R1","R2","R3","R4","R5"),lty=1:5,lwd=2)
}

