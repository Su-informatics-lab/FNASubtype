buildInputMatrix <- function(expr) {
   targetGenes <- getTargetGenes()

   # Remove the genes that we're not using
   geneRows = rownames(expr)
   geneExpressions <- expr[match(targetGenes, geneRows),]

   # Restructure the gene expressions as a matrix with subjects
   # as rows and genes (variables) as columns.
   t(as.matrix(geneExpressions))
}

generatePredictions <- function(inputMatrix) {
   coefficients <- getCoefficients()
   intercept <- coefficients[1]
   genes <- coefficients[-1]

   # Multiply the input matrix by the gene coefficients
   prediction <- intercept + (inputMatrix %*% genes)

   # And convert to a probability
   prediction <- exp(prediction) / (1 + exp(prediction))

   # Turn the predicted probabilities into a data frame with both the
   # probability and the predicted cancer type.
   prediction <- data.frame(
      probability=prediction,
      type=factor(ifelse(prediction > 0.5, 'A', 'S'))
   )

   prediction
}
