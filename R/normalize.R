substituteZeroExpressions <- function(Expr) {
   # TODO: Where does this expression come from?
   replacementValue <- log(min(Expr[Expr > 0]) / 2, base=2)
   Expr[Expr == 0] <- replacementValue 

   Expr
}
