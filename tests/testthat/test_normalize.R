context("Normalization Routines")

## Substitution of Zero Expressions

test_that("all zeros are replaced", {
   ## Create a random gene expression matrix and set a portion of the
   ## values to zero.
   expr <- matrix(0, nrow=5, ncol=10)
   expr <- expr + runif(expr)
   expr[seq(1, length(expr), 7)] <- 0

   expr <- substituteZeroExpressions(expr)

   expect_true(all(abs(expr) > 1e-12))
})
