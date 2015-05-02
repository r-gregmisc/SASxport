"FDR" <-
function (p)
{
    m <- length(p)
    tmp <- sort(p, index.return = TRUE)
    sortp <- tmp$x
    idx <- tmp$ix
    sortp <- sortp * m/(1:m)
    for (i in (m - 1):1) {
        if (sortp[i] > sortp[i + 1])
            sortp[i] <- sortp[i + 1]
    }
    result <- NULL
    result[idx] <- sortp
    result
}
