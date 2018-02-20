## Gene Normalization

normalizeGenes <- function(expr, sourceColumn, targetColumn) {
   anno <- getAnnotations()

   exprGenes <- rownames(expr)
   annoGenes <- anno[, sourceColumn]

   matchIndices <- na.omit(match(exprGenes, annoGenes))
   matchGeneNames <- anno[matchIndices, targetColumn]

   rownames(expr)[exprGenes %in% annoGenes] <- matchGeneNames

   expr
}

normalizeEnsemblGenes <- function(expr) {
   normalizeGenes(expr, 'Ensembl.ID', 'Gene.Name')
}

normalizeProbeIds <- function(expr) {
   normalizeGenes(expr, 'probe.id', 'Gene.Name')
}


## Expression Normalization

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
