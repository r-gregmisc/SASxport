# Convert SAS date values to R 'Date' objects
fromSASDate <- function( sDate )
  {
    sasBase <- as.Date(strptime("01/01/1960 0:00:00", "%m/%d/%Y %H:%M:%S", tz="GMT")) # days
    sasBase + sDate
  }


# Convert SAS DateTime values to R 'POSIXct' objects
fromSASDateTime <- function( sDateTime )
  {
    sasBaseSeconds <- as.numeric(ISOdatetime(1960,1,1,0,0,0) - 0)
    retval <- sDateTime  + sasBaseSeconds
    class(retval) <- c("POSIXt","POSIXct")
    retval
  }

