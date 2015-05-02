"power.simu" <-
function(avg.power, nrep.simu, ngenes.null)
{
ngenes <- dim(avg.power)[1]

temp.power <- avg.power[(ngenes.null+1) : ngenes,(nrep.simu - 1)]
# only consider power for genes from Ha
# column number + 1 for avg.power is the sample size for t-test in avg.power
colnames(temp.power) <- as.character(nrep.simu)

temp <- (temp.power >= 0.8)
# logical matrix stores whether each est power >= 0.8 or not

propn.80 <- apply(temp, 2, mean)
# prop'n of tests with power>=0.8 for each ssize

power.real <- list(temp.power, propn.80)
names(power.real) <- c("true.power", "propn.80")

# output will be a list
# 1st element in list is the matrix of calculated power (ngenes x length(nrep.simu))
# 2nd element is a vector of propn.80 with length=ngenes

power.real
}
