####
## Figure 1
####
##.libPaths("~warneg/Rlib")
library(gplots)

data(Titanic)

dframe <- as.data.frame(Titanic) # convert to 1 entry per row format

survived <- dframe[dframe$Survived=="Yes",]
attach(survived)

pdf("Figure1.pdf")
 
balloonplot(x=Class, y=list(Age, Sex), z=Freq,
            sort=TRUE, show.zeros=TRUE, cum.margins=FALSE,
            dotcol="white", show.margins=FALSE,
            main="BalloonPlot : Surviving passengers")

dev.off()

detach(survived)


####
## Figure 2
####
library(gplots)

data(Titanic)

dframe <- as.data.frame(Titanic) # convert to 1 entry per row format

survived <- dframe[dframe$Survived=="Yes",]
attach(survived)

pdf("Figure2.pdf")

balloonplot(x=Class,
            y=list(Age, Sex),
            z=Freq,
            sort=TRUE,
            #dotcol="green",
            show.zeros=TRUE,
            cum.margins=FALSE,
            main="BalloonPlot : Surviving passengers"
            )

title(main=list("Circle area is proportional to number of passengers",
           cex=0.9),
      line=0.5)

dev.off()

detach(survived)


####
## Figure 3
####

attach(dframe)
colors <- ifelse( Survived=="Yes", "green", "magenta")

pdf("Figure3.pdf")

balloonplot(x=Class,
            y=list(Survived,Age,Sex),
            z=Freq,
            dotcol = colors,
            show.zeros=TRUE,
            cum.margins=FALSE,
            main="BalloonPlot : Passenger Class by Survival, Age and Sex"
            )
title(main=list("Circle area is proportional to number of passengers",
           cex=0.9),
      line=0.5)

dev.off()

detach(dframe)

####
## Figure 4
####

attach(dframe)
colors <- ifelse( Survived=="Yes", "green", "magenta")

pdf("Figure4.pdf")

balloonplot(x=Class,
            y=list(Survived, Age, Sex),
            z=Freq,
            sort=FALSE,
            dotcol=colors,
            show.zeros=TRUE,
            main="BalloonPlot : Passenger Class by Survival, Age and Sex"
            )

points( x=1, y=8, pch=20, col="magenta")
points( x=1, y=4, pch=20, col="green")

title(main=list("Circle area is proportional to number of passengers",
           cex=0.9),
      line=0.5)

dev.off()

detach(dframe)
