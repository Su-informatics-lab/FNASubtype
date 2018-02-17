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


# Annotation Data

test_that("annotation data is a 19x5 data frame", {
   anno <- getAnnotations()

   expect_equal(nrow(anno), 19)
   expect_equal(ncol(anno), 5)
   expect_true(is.data.frame(anno))
})

test_that("get housekeeping genes returns correct records", {
   hkg <- getHousekeepingGenes()

   expect_equal(nrow(hkg), 4)
   expect_true(
      setequal(hkg$probe.id, c('200801_x_at', '208695_s_at', '212869_x_at', '213583_x_at'))
   )
})
