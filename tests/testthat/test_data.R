context("Data Utilities")


# Coefficient Data

test_that("coefficient data is a 16x1 matrix", {
   coefs <- getCoefficients()

   expect_equal(nrow(coefs), 16)
   expect_equal(ncol(coefs), 1)
   expect_true(is.numeric(coefs))
})

test_that("coefficient data's first rowname is blank", {
   coefs <- getCoefficients()

   expect_equal(rownames(coefs)[1], "")
})

test_that("coefficient rows 2:16 are not blank", {
   coefs <- getCoefficients()

   expect_true(all(rownames(coefs)[-1] != ""))
})


# Helper Functions

test_that("get target genes returns correct gene list", {
   expected <- c(
      '203074_at', '209351_at', '214580_x_at', '217272_s_at', '221854_at',
      '201925_s_at', '206239_s_at', '207847_s_at', '209598_at', '211024_s_at',
      '212950_at', '219580_s_at', '201820_at', '209863_s_at', '213139_at'
   )

   actual <- getTargetGenes()

   expect_equal(actual, expected)
})


# Annotation Data

test_that("annotation data is a 19x5 data frame", {
   anno <- getAnnotations()

   expect_equal(nrow(anno), 19)
   expect_equal(ncol(anno), 5)
   expect_true(is.data.frame(anno))
})

test_that("annotation data columns are all strings", {
   anno <- getAnnotations()

   expect_true(all(sapply(anno, class) == "character"))
})

test_that("get housekeeping genes returns correct records", {
   hkg <- getHousekeepingGenes()

   expect_equal(nrow(hkg), 4)
   expect_true(
      setequal(hkg$probe.id, c('200801_x_at', '208695_s_at', '212869_x_at', '213583_x_at'))
   )
})
