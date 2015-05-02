"t.decision.FDR" <-
function(tp, sig.level)
{ temp <- apply(tp, 2, FDR)
  tp <= sig.level
}
