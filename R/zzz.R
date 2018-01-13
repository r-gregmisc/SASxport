.onAttach <- function(libname, pkgname)
{
  ver  <- utils::packageDescription("SASxport", fields="Version")
  date <- utils::packageDescription("SASxport", fields="Date")

  base::packageStartupMessage(
    c(
      "\n",
      "Loaded SASxport version ", ver,  " (", date ,").\n",
      "\n",
      "  Type `?SASxport' for usage information.\n",
      "\n"
      )
  )
}
