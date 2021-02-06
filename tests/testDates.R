library(SASxport)
Sys.setenv("TZ"="GMT")

## Create a small data set containing dates, times, and date-times

dates <- c("02/27/92", "02/27/92", "01/14/92", "02/28/92", "02/01/92")
times <- c("23:03:20", "22:29:56", "01:03:30", "18:21:03", "16:56:26")


temp <- data.frame(
  x=c(1L, 2L, 3L, 4L, 5L), # integer
  z=c(1.1, 2.2, 3.3, 4.4, 5.5), # real
  y=c('a', 'B', 'c', 'd', 'e' ),
  date=as.Date(dates, format="%m/%d/%y"),
  datetime=strptime( paste(dates,times), "%m/%d/%y %H:%M:%S"),
  stringsAsFactors = FALSE
)

print(temp)

write.xport( DATETIME=temp, file="datetime.xpt")
temp2 <- read.xport(file="datetime.xpt",
                    names.tolower=TRUE,
                    verbose = TRUE)

print(temp2)

# Strip off SASformats added by read.xport so comparison won't fail
for(col in colnames(temp2))
  SASformat(temp2[[col]]) <- NULL

identical(temp, temp2)

# Test for issue #19: toSAS() - The number of seconds since
# 1960-01-01:00:00:00 GMT is greater than it is supposed to be

zeroDate <- ISOdate(1960, 01, 01, 00, 00, 00, tz="GMT")
zeroSAS <- toSAS(zeroDate, format="DATETIME19.")

stopifnot(zeroSAS==0)

