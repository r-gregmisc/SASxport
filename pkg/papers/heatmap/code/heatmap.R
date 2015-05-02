.libPaths("/home/jainn02/projects/papers/heatmap2/Rlib")
#setwd("/home/jainn02/projects/papers/heatmap2/code")

##library(mva)
library (stats)
library(gplots)

#load the significant data
load("regression_rank_image_II.Rda")
##source("~/src/gregmisc/R/heatmap.2.R")


###
# Utility Functions
###

#
# Select columns matching all 'with' patterns, and excluding those
# with any 'without' patterns
#

## Function 'matchcols' no longer needed - part of gdata now.

## matchcols <- function(object, with, without, ...)
##  {
##    cols <- colnames(object)
##
##    # include columns matching 'with' pattern(s)
##    if(!missing(with))
##      cols <- cols[grep(with, cols, ...)]
##
##    # exclude columns matching 'without' pattern(s)
##    if(!missing(without))
##      for(i in 1:length(without))
##        {
##          omit <- grep(without[i], cols, ...)
##          if(length(omit)>0)
##            cols <- cols[-omit]
##        }
##
##    cols
##  }
##

#
# Convert p-values into symbols
#
flagvals <- function(x, pre="", post="", symbol="*")
  {
    x[x>1] <- 1

    cutpoints <-  c(0, 0.001, 0.01, 0.05, 0.1, 1)
    
    symbols <- c(
                 paste(rep(symbol,3),collapse=''),
                 paste(rep(symbol,2),collapse=''),
                 paste(rep(symbol,1),collapse=''),
                 ".",
                 " ")
    
    flag <- symnum(x, corr = FALSE, na = FALSE, 
                   cutpoints = cutpoints,
                   symbols = symbols)
    flag <- paste(pre, flag, post, sep="")
    flag[x>0.1] <- ""
    flag
  }


###
# Custom heatmap plot
###

heat <- function( data, pvals, main, file=NULL, centercut=0.7,
ncolors=31, cutoff=3, ... ) {

    if(!is.null(file))
      {
        postscript(file=paste(file,"eps",sep='.'),
                   onefile=F,pointsize=0.75,horizontal=F)
        dev.control('enable') # enable plot recording
      }

    data <- logratio2foldchange(data)
    
    colors <- greenred(ncolors)    
    breaks <- c(
                seq(-cutoff,-centercut, length=ceiling(ncolors+1)/2),
                seq(centercut,cutoff, length=ceiling(ncolors+1)/2)
                )

info <- heatmap.2(data,
                  ...)
    
##    info <- heatmap.2(data,
##                      cellnote=pvals,
##                      Colv=1:4,
##                      col=colors,
##                      scale="none",
##                      collabel.space=10,
##                      rowlabel.space=20,
##                      vline=c(-1),
##                      trace="col",
##                      breaks= breaks,
##                      scale01 = scale01,
##                      min.scale = -cutoff+1,
##                      max.scale = cutoff-1,
##                      density.info = "none",
##                      ...)
##    
    par(mfrow=c(1,1))
    par(cex=2)
    title(main="Yeast Response to Toxic Treatments\n")
    
    par(cex=1)
    title(main=paste("\n", main, " (n=", nrow(data), ")", sep=""))
    title(main=paste("\n\n\nFold Change Values truncated to [-",
            cutoff, ",", cutoff,"]", sep=""))
    title(main="\n\n\n\n\nSignif. codes: 0 `***' 0.001 `**' 0.01 `*' 0.05 `.' 0.1 ` ' 1 ")
    title(main="\n\n\n\n\n\n\n+ = individual group significance, * linear model, # quadratic model")

    if(!is.null(file))
      {
        dev.copy(bitmap, file=paste(file,"png",sep='.'), res=100)
        dev.off()
        
        dev.copy(pdf, file=paste(file,"pdf",sep='.'), pointsize=0.75)
        dev.off()

        # close postscript device
        dev.off()

      }

    info
  }

################
# Linear or quadratic cisplatin 
################

annotated.best <- data.tab.annotated

# Give better labels to columns
colnames(annotated.best)[11] <- "NaCl"

colnames(annotated.best)[12] <- "Cis 3 ugml"
colnames(annotated.best)[13] <- "Cis 10 ugml"
colnames(annotated.best)[14] <- "Cis 30 ugml"

colnames(annotated.best)[39] <- "Cis Linear"
colnames(annotated.best)[43] <- "Cis Quadratic"

colnames(annotated.best)[32] <- "NaCl P-Value"

colnames(annotated.best)[33] <- "Cis 3 ugml P-Value"
colnames(annotated.best)[34] <- "Cis 10 ugml P-Value"
colnames(annotated.best)[35] <- "Cis 30 ugml P-Value"

colnames(annotated.best)[42] <- "Cis Linear P-Value"
colnames(annotated.best)[46] <- "Cis Quad P-Value" 

# Use Gebank id:Genbook name as row names
annotated.best$"Genbank.ID" <- sub('^gb.','',
                                      sub(';.*$','',
                                          as.character(annotated.best$"Affymetrix.description")
                                          )
                                      )
row.names <- paste(
                   as.character(annotated.best$"Genbank.ID"),
                   as.character(annotated.best$"GeneBook.name"),
                   sep=": "
                   )

row.names <- make.names(row.names, unique=T)

rownames(annotated.best) <- row.names


# Add significancs flags 
q.Cis3  <- flagvals(annotated.best[,"Cis 3 ugml P-Value"],  symbol='+')
q.Cis10 <- flagvals(annotated.best[,"Cis 10 ugml P-Value"], symbol='+')
q.Cis30 <- flagvals(annotated.best[,"Cis 30 ugml P-Value"], symbol='+')

q.lin   <- flagvals(annotated.best[,"Cis Linear P-Value"],  symbol='*')
q.quad  <- flagvals(annotated.best[,"Cis Quad P-Value"],    symbol="#" )

q.NaCl  <- flagvals(annotated.best[,"NaCl P-Value"],        symbol='+')

annotated.best$Cis3flags  <- paste(q.Cis3,  q.lin, q.quad)
annotated.best$Cis10flags <- paste(q.Cis10, q.lin, q.quad)
annotated.best$Cis30flags <- paste(q.Cis30, q.lin, q.quad)
annotated.best$NaClflags  <- q.NaCl


# Create group membership indicators

NaCl   <- (annotated.best[,"NaCl P-Value"]              < 0.05 )

Cis3   <- (annotated.best[,"Cis 3 ugml P-Value"]  < 0.05 )
Cis10  <- (annotated.best[,"Cis 10 ugml P-Value"] < 0.05 )
Cis30  <- (annotated.best[,"Cis 30 ugml P-Value"] < 0.05 )

Linear <- (annotated.best[,"Cis Linear P-Value"] < 0.05)
Quad   <- (annotated.best[,"Cis Quad P-Value"] < 0.05 )



annotated.best$group.Cis.updown <- Linear | Quad 
annotated.best$group.Cis.others <- (Cis3 | Cis10 | Cis30) & !(annotated.best$group.Cis.updown)
annotated.best$group.NaCl       <- NaCl & !annotated.best$group.Cis.updown & !annotated.best$group.Cis.others

cols.estimates <- c("Cis 3 ugml", "Cis 10 ugml", "Cis 30 ugml", "NaCl",
                    "Cis Linear", "Cis Quadratic")
cols.flags     <- c("Cis3flags", "Cis10flags", "Cis30flags", "NaClflags")
cols.pvalues   <- c("NaCl P-Value", "Cis 3 ugml P-Value", "Cis 10 ugml P-Value", "Cis 30 ugml P-Value", "Cis Linear P-Value", "Cis Quad P-Value")




######
# "All Statistically Significant Genes with a Linear or Quadratic Trend for Cisplatin",
######

names(annotated.best) <- names(annotated.best)
datamat <- annotated.best[,cols.estimates]
flagmat <- annotated.best[,cols.flags]
pmat    <- annotated.best[cols.pvalues]


write.table(datamat, file="heatmap.datamap.tab", sep="\t")

#### FIXME:  These depended on having a subset of annotated.best.   

lin.up   <- ((datamat[,"Cis Linear"] > 0) &
             (pmat[,"Cis Linear P-Value"] < 0.05)) 

lin.down <- ((datamat[,"Cis Linear"] < 0) &
             (pmat[,"Cis Linear P-Value"] < 0.05)) 

quad.up  <- ((datamat[,"Cis Quadratic"] > 0 ) &
             (pmat[,"Cis Quad P-Value"] < 0.05 )) 

quad.down  <- ((datamat[,"Cis Quadratic"] < 0 ) &
             (pmat[,"Cis Quad P-Value"] < 0.05 ))

up.up <- lin.up & quad.up
up.down <- lin.up & quad.down
up <- lin.up & !quad.up & !quad.down
.up <- quad.up & !lin.up & !lin.down
  
down.down <- lin.down & quad.down
down.up <- lin.down & quad.up
down <- lin.down & !quad.up & !quad.down
.down <- quad.down & !lin.up & !lin.down


dir <- c(
         which(up.up),
         which(up),
         which(up.down),
         which(.up),
         rev(which(.down)),
         rev(which(down.up)),
         rev(which(down)),
         rev(which(down.down)),
         )

seps <- cumsum(
               c(
                 sum(up.up),
                 sum(up),
                 sum(up.down),
                 sum(.up),
                 sum(.down),
                 sum(down.up),
                 sum(down),
                 #sum(down.down),
                 ) 
               )

info <- heat(
             data=as.matrix(datamat[dir,1:4]),
             pvals=as.matrix(flagmat[dir,1:4]),
             file="heatmap.group.Cis.updown",
             main="All Statistically Significant Genes with a Linear or Quadratic Trend for Cisplatin",
#            Rowv=dir,
             dendrogram="none",
             colsep=3,
             rowsep=seps,
             notecex=1.5
            )

tmpmat <- as.matrix(datamat[dir,1:4])

write.table(tmpmat, file="heatmap.group.Cis.updown.csv", sep=",")
write.table(rownames(tmpmat), file="heatmap.group.Cis.updown.names.csv", sep=",")

###################
# Other Signif Cisplatin
###################


group.Cis.others <- Cis3 | Cis10 | Cis30
group.Cis.updown <- Linear | Quad 

keep <- group.Cis.others & !group.Cis.updown
dir  <- order(datamat[keep,"Cis 30 ugml"])
info <- heat(
             data=as.matrix(datamat[keep,][dir,]),
             pvals=as.matrix(flagmat[keep,][dir,]),             
             file="heatmap.other",
             main="Other Statistically Significant Gene Expression Changes for Cisplatin",
             dendrogram="none",
             Rowv = dir,
             colsep=3,
             notecex=1.5
            )

tmpmat <- as.matrix(datamat[keep,][dir,])
write.table(rownames(datamat), file="heatmap.other.names.csv", sep=",")

###################
# Signif NaCl
###################

dir  <- order(
              (annotated.best[NaCl,])[,"NaCl"]
              )

info <- heat(
             data= as.matrix((datamat[NaCl,])[dir,]),
             pvals=as.matrix((flagmat[NaCl,])[dir,]),             
             file="heatmap.NaCl.signif",
             main="All Statistically Significant Gene Expression Changes for NaCl",
             dendrogram="none",
             colsep=3,
             notecex=1.5
            )

tmpmat <- as.matrix((datamat[NaCl,])[dir,])
write.table(rownames(datamat), file="heatmap.NaCl.signif.names.csv", sep=",")


####

save.image("heatmap.Rda")



### Functions to obtain normalized and ordinal intensity values

## normalization

scaled.data <- function(x,...) ## column centering and column scaling
  {
    ret.val <- t(scale(t(x),center=TRUE, scale=TRUE))

    if(!is.null(rownames(x)))
      rownames(ret.val) <- rownames(x)
    if(!is.null(colnames(x)))
      colnames(ret.val) <- colnames(x)
    
    return(ret.val)
  }


## ordinal value calculation

ordinal.data <- function(x){
  ret.val <-t(apply(x,1,function(x) order(order(x))))

  if(!is.null(rownames(x)))
    rownames(ret.val) <- rownames(x)
  if(!is.null(colnames(x)))
    colnames(ret.val) <- colnames(x)

  return(ret.val)
}

## Plotting the data

## Normal (traidtional) heatmap - with significant genes
plot.data <- as.matrix((datamat[NaCl,])[dir,])

dim(plot.data) ## 71 * 6


heatmap(plot.data[1:7,])
heatmap(scaled.data(plot.data[1:7,]))
heatmap(ordinal.data(plot.data[1:7,]))

