isURL <- function(x)
{
  sapply(x, function(X) any(startsWith(x, c("https://", "http://", "ftp://"))) )
}
