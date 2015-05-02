"power.real" <-
function(avg.power)

{
 colnames(avg.power) <- as.character((1:dim(avg.power)[2]) + 1)
 
 temp <- (avg.power >= 0.8)
 # logical matrix stores whether each real power >= 0.8 or not

 propn.80 <- apply(temp, 2, mean)
 # prop'n of tests with power>=0.8 for each ssize

 power.result <- list(avg.power, propn.80)
 names(power.result) <- c("avg.power", "propn.80")

 # output is a list with the same length as nrep.est
 # each element of the list consists of results for 
 # each set of sd based on corresponding nrep.est

power.result

}
