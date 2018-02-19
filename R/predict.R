buildInputMatrix <- function(expr) {
   targetGenes <- getTargetGenes()

   # Remove the genes that we're not using
   geneRows = rownames(expr)
   geneExpressions <- expr[match(targetGenes, geneRows),]

   # Restructure the gene expressions as a matrix with subjects
   # as rows and genes (variables) as columns.
   t(as.matrix(geneExpressions))
}
