context("Prediction")


# Input Matrix

test_that("build input matrix returns subjects as rows", {
   load(system.file(file.path('testdata', 'expressions.rda'), package=.PACKAGE_NAME))
   
   expected <- colnames(expr)

   inputMatrix <- buildInputMatrix(expr)
   actual <- rownames(inputMatrix)

   expect_equal(actual, expected)
})

test_that("build input matrix returns only genes of interest", {
   load(system.file(file.path('testdata', 'expressions.rda'), package=.PACKAGE_NAME))
   
   expected <- getTargetGenes()

   inputMatrix <- buildInputMatrix(expr)
   actual <- colnames(inputMatrix)

   expect_equal(actual, expected)
})
