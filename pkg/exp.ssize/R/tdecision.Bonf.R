"tdecision.Bonf" <-
function(tp, sig.level)
{ alpha <- sig.level/dim(tp)[1]
  tp <= alpha
}
