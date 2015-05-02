# $Id$

if(is.R())
  {
    # make original lowess into the default method
    if(R.version$major == 1 && R.version$minor < 9)
      lowess.default <- base::lowess
    else
      lowess.default <- stats::lowess

    lowess  <- function(x,...)
      UseMethod("lowess")

    # add "..." to the argument list to match the generic
    formals(lowess.default) <- c(formals(lowess.default),alist(...= ))

    NULL

  } else
  {

    # make original lowess into the default method
    lowess.default  <- getFunction("lowess",where="main")

    lowess  <- function(x,...)
      UseMethod("lowess")

    NULL
  }



"lowess.formula" <-  function (formula,
                               data = parent.frame(), subset, na.action,
                               f=2/3,  iter=3,
                               delta=.01*diff(range(mf[-response])), ... )
{
  if (missing(formula) || (length(formula) != 3))
    stop("formula missing or incorrect")
  if (missing(na.action))
    na.action <- getOption("na.action")
  m <- match.call(expand.dots = FALSE)
  if (is.matrix(eval(m$data, parent.frame())))
    m$data <- as.data.frame(data)
  m$...  <- m$f <- m$iter <- m$delta <- NULL
  m[[1]] <- as.name("model.frame")
  mf <- eval(m, parent.frame())
  response <- attr(attr(mf, "terms"), "response")
  lowess.default(mf[[-response]], mf[[response]], f=f, iter=iter, delta=delta)
}
