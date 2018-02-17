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


## Housekeeping Gene Expressions

test_that("housekeeping genes expressions correctly extracted", {
   load(system.file(file.path('testdata', 'expressions.rda'), package=.PACKAGE_NAME))

   expr <- getHousekeepingGeneExpressions(expr)

   expect_equal(nrow(expr), 4)
   expect_equal(rownames(expr), c('200801_x_at', '208695_s_at', '212869_x_at', '213583_x_at'))

   ## The following is basically just a checksum in lieu of testing the whole matrix
   ## or just a portion
   expect_equal(sum(expr), 345.29)
})
