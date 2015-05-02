"calc.power.est" <-
function(sd, nrep.simu, delta, sig.level)
{

calc.power <- matrix(0, nr = length(sd), nc = length(nrep.simu))

for (j in 1:length(nrep.simu))
  {   calc.power[,j] <- pow(sd=sd, n=nrep.simu[j], delta=delta,
                 sig.level=sig.level)
   } # end of for
colnames(calc.power) <- as.character(nrep.simu)
# colnames(calc.power) <- colnames(calc.power, do.NULL = FALSE, prefix = "nrep.simu")
# the above line seems to have no effect
temp <- (calc.power >= 0.8)
# logical matrix stores whether each est power >= 0.8 or not

propn.80 <- apply(temp, 2, mean)
# prop'n of tests with power>=0.8 for each ssize

power.est.sd <- list(calc.power, propn.80)
names(power.est.sd) <- c("calc.power", "propn.80")

# output will be a list
# 1st element in list is the matrix of calculated power (ngenes x length(nrep.simu))
# 2nd element is a vector of propn.80 with length=ngenes

power.est.sd
}
