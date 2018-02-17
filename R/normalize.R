substituteZeroExpressions <- function(expr) {
   # TODO: Where does this expression come from?
   replacementValue <- log(min(expr[expr > 0]) / 2, base=2)
   expr[expr == 0] <- replacementValue 

   expr
}

getHousekeepingGeneExpressions <- function(expr) {
   hkg <- getHousekeepingGenes()
   hkGeneIds <- hkg$probe.id

   expr[match(hkGeneIds, rownames(expr)), ]
}
