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


# Predicted Outcomes

test_that("generate predictions probability column in [0, 1]", {
   load(system.file(file.path('testdata', 'inputMatrix.rda'), package=.PACKAGE_NAME))

   prediction <- generatePredictions(inputMatrix)

   expect_true(all(prediction$probability >= 0))
   expect_true(all(prediction$probability <= 1))
})

test_that("generate predictions type column is A when probability > 0.5", {
   load(system.file(file.path('testdata', 'inputMatrix.rda'), package=.PACKAGE_NAME))

   prediction <- generatePredictions(inputMatrix)

   prediction <- prediction[prediction$prob > 0.5,]

   expect_true(all(prediction$type == 'A'))
})

test_that("generate predictions type column is S when probability <= 0.5", {
   load(system.file(file.path('testdata', 'inputMatrix.rda'), package=.PACKAGE_NAME))

   prediction <- generatePredictions(inputMatrix)

   prediction <- prediction[prediction$prob <= 0.5,]

   expect_true(all(prediction$type == 'S'))
})

test_that("generate predictions retains subject rownames", {
   load(system.file(file.path('testdata', 'inputMatrix.rda'), package=.PACKAGE_NAME))

   expected <- rownames(inputMatrix)

   prediction <- generatePredictions(inputMatrix)

   expect_equal(rownames(prediction), expected)
})
