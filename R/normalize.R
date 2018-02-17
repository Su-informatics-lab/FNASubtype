substituteZeroExpressions <- function(expr) {
   ## If any gene expressions are 0, replace them.
   replacementValue <- log(min(expr[expr > 0]) / 2, base=2)
   expr[expr == 0] <- replacementValue 

   expr
}

getHousekeepingGeneExpressions <- function(expr) {
   hkg <- getHousekeepingGenes()
   hkGeneIds <- hkg$probe.id

   expr[match(hkGeneIds, rownames(expr)), ]
}


normalizeData <- function(expr) {
   expr <- substituteZeroExpressions(expr)

   housekeepingExpressions <- getHousekeepingGeneExpressions(expr)

   ## Normalize all of the genes by the mean housekeeping expression
   normalizationFactor <- mean(as.matrix(housekeepingExpressions))
   expr <- expr / normalizationFactor

   expr
}
