crit.fn  <- function(crit, ratio, df, ncp, tside) 
  {
    lratio <- log(ratio)
    
    temp <- log(tside) +
            log(pt(crit, df,          lower=FALSE )) - 
            log(pt(crit, df, ncp=ncp, lower=FALSE ))

    abs(temp-lratio)
  }

power.t.test.FDR <- function (sd=1, n=NULL, delta=NULL,
                              FDR.level=0.05,
                              pi0,
                              power=NULL, 
                              type=c("two.sample", "one.sample", "paired"),
                              alternative=c("two.sided", "one.sided")) 

{
    if (sum(sapply(list(n, delta, sd, power, FDR.level), is.null)) != 1) 
        stop("exactly one of n, delta, sd, power, and FDR.level must be NULL")
    
    type <- match.arg(type)
    alternative <- match.arg(alternative)
    tsample <- switch(type, one.sample=1, two.sample=2, paired=1)
    tside <- switch(alternative, one.sided=1, two.sided=2)

    p.body <- quote(
                    {
                      df <- (n - 1) * tsample
                      ncp <- sqrt(n/tsample)*delta/sd
                      ratio <- FDR.level * (1-pi0) / ((1-FDR.level) * pi0)
                      
                      ## difference from power.t.test
                      ## the crit value is determined by FDR level to control and 
                      ## pi_0, the proportion of non-DE genes for fixed n

                      crit <- optimize(crit.fn,
                                       interval=c(0.0001, 25),
                                       tol=1e-10,
                                       ratio=ratio,
                                       df=df,
                                       ncp=ncp,
                                       tside=tside)$minimum

                      pt(crit, df, ncp=ncp, lower=FALSE)
                    }
                    )
    
    if (is.null(power)) 
        power <- eval(p.body)
    else if (is.null(n)) 
        n <- uniroot(function(n) eval(p.body) - power,
                     interval=c(2, 1e+07),
                     )$root
    else if (is.null(sd)) 
        sd <- uniroot(function(sd) eval(p.body) - power,
                      delta * c(1e-07, 1e+07))$root
    else if (is.null(delta)) 
      delta <- uniroot(function(delta) eval(p.body) - power, 
                       sd * c(1e-07, 1e+07))$root
    else if (is.null(FDR.level)) 
      FDR.level <- uniroot(function(FDR.level)
                           eval(p.body) - power,
                           c(1e-10, 1 - 1e-10))$root
    else
      stop("internal error")
    
    NOTE <- switch(type, paired="n is number of *pairs*, sd is std.dev. of *differences* within pairs", 
                   two.sample="n is number in *each* group", NULL)
    
    METHOD <- paste(switch(type, one.sample="One-sample", two.sample="Two-sample", 
                           paired="Paired"), "t test power calculation")
    
    structure(list(n=n, delta=delta, sd=sd, FDR.level=FDR.level, 
                   power=power, alternative=alternative, note=NOTE, 
                   method=METHOD), class="power.htest")
}

