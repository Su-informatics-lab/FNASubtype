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
