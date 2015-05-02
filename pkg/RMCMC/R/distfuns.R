# Table of distributions   (FullNames, ShortNames, random, density, package)
distfuns <-
  list(
       "Normal" = list(
         aliases=c('N','Norm','Normal','Gaussian'),
         random='rnorm',
         density='dnorm',
         logdensity='log.dnorm',
         package='stats'),

       "Inverted Gamma" = list(
         aliases=c("IG", 'InvGamma', "Inverted Gamma"),
         random='rinvgamma',
         density='dinvgamma',
         logdensity='log.dinvgamma',         
         package='MCMCpack'),

       "Gamma" = list(
         aliases=c("G", "Gamma"),
         random="rgamma",
         density="dgamma",
         logdensity="log.dgamma",
         package='stats'),

       "Exponential" = list(
         aliases=c("E", "Exp", "Exponential"),
         random="rexp",
         density="dexp",
         logdensity="log.dexp",
         package="stats"),

       "Poisson" = list(
         aliases=c("P", "Pois", "Poisson"),
         random="rpois",
         density="dpois",
         logdensity="log.dpois",
         package="stats"),
       
       )

log.dnorm <- function(...) dnorm(..., log=TRUE)
log.dinvgamma <- function(...) log(dinvgamma(...))
log.dgamma <- function(...) dgamma(..., log=TRUE)
log.dexp <- function(...) dexp(..., log=TRUE)
log.dpois <- function(...) dpois(..., log=TRUE)

make.lookup.table <- function(distfuns)
{
  retval <- list()
  for(item in distfuns)
    {
      # enforce presence of fields
      fields <- c("aliases","random","density","logdensity","package")
      if(!all(fields %in% names(item)))
         stop("Missing field(s) ",
              paste(fields[!(fields %in% names(item))],collapse=", "),
              " in item ", str(item))
      
      
      aliases <- item$aliases
      item$aliases <- NULL
      
      for( name in aliases )
        retval[[name]] <- item
    }
  retval
}

lookup.table <- make.lookup.table(distfuns)
