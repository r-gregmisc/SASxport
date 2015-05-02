loadMessage <- function()
{
  cat("\n")
  ver <-packageDescription("SASxport", fields="Version") 
  date <- packageDescription("SASxport", fields="Date") 
  cat("Loaded SASxport version ", ver,  " (", date ,").\n", sep="")
  cat("\n")
  cat("  Type `?SASxport' for usage information.\n")
  cat("\n")
}

.onLoad <- function(lib, pkg) {
  loadMessage()
}
