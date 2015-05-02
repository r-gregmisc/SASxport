# $Id$

smartlegend <- function(x=c("left","center","right"),
                        y=c("top","center","bottom"),
                        ..., inset=0.05 )
  {

    .Deprecated('legend', 'graphics')

    x <- match.arg(x)
    y <- match.arg(y)

    usr <- par("usr")
    inset.x <- inset * (usr[2] - usr[1])
    inset.y <- inset * (usr[4] - usr[3])

    if(x=="left")
      {
        x.pos <- usr[1] + inset.x
        xjust = 0
      }
    else if(x=="center")
      {
        x.pos <- (usr[1] + usr[2])/2
        xjust = 0.5
      }
    else # y=="right"
      {
        x.pos <- usr[2] - inset.x
        xjust = 1
      }

    if(y=="bottom")
      {
        y.pos <- usr[3] + inset.y
        yjust = 0
      }
    else if(y=="center")
      {
        y.pos <- (usr[3] + usr[4])/2
        yjust = 0.5
      }
    else
      {
        y.pos <- usr[4] - inset.y
        yjust = 1
      }


    if(par("xlog")) x.pos <- 10^x.pos
    if(par("ylog")) y.pos <- 10^y.pos

    legend( x=x.pos, y=y.pos, ..., xjust=xjust, yjust=yjust)
  }


