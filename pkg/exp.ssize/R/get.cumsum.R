"get.cumsum" <-
function(mat)
{ # take an argument of matrix and reurn the cumsum by col
 t(apply(mat,1,cumsum)) 
}
