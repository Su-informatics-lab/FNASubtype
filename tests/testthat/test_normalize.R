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



## Data Normalization

test_that("normalize data does not change structure of input data", {
   load(system.file(file.path('testdata', 'expressions.rda'), package=.PACKAGE_NAME))

   before <- expr
   after <- normalizeData(expr)

   expect_equal(nrow(after), nrow(before))
   expect_equal(ncol(after), ncol(before))
   expect_equal(rownames(after), rownames(before))
   expect_equal(colnames(after), colnames(before))
})

test_that("normalize data produces the correct result", {
   load(system.file(file.path('testdata', 'expressions.rda'), package=.PACKAGE_NAME))

   expr <- normalizeData(expr)

   ## Checksum
   expect_equal(sum(expr), 78.1205, tolerance=1e-4)
})


## Gene Normalization: Ensemble ID to Gene Name

test_that("normalizing ensemble genes converts recognized Ensemble IDs", {
   ensembl <- loadCsvData(system.file(file.path('testdata', 'sample-ensembl.csv'), package=.PACKAGE_NAME))

   expected <- c(
      'ACTB', 'RPL39', 'TPT1', 'EEF1A1', 
      'ENSG00000268104.2', 'ENSG00000186832.7', 'ENSG12345789012.3',
      'TP63', 'KRT14', 'TMC5', 'ANXA8L2', 'KRT5', 'PNMA2',
      'GPR116', 'MUC1', 'SERPINB13', 'SNAI2', 'NKX2-1',
      'KRT6A', 'CD55', 'PKP1', 'SPINK1'
   )

   actual <- normalizeEnsemblGenes(ensembl)

   expect_equal(rownames(actual), expected)
})

## Gene Normalization: Probe ID to Gene Name

test_that("normalizing probes converts recognized probe IDs", {
   probe <- loadCsvData(system.file(file.path('testdata', 'sample-probeid.csv'), package=.PACKAGE_NAME))

   expected <- c(
      'ACTB', 'RPL39', 'TPT1', 'EEF1A1', 
      '219795_at', '209800_at', 'POS_A',
      'TP63', 'KRT14', 'TMC5', 'ANXA8L2', 'KRT5', 'PNMA2',
      'GPR116', 'MUC1', 'SERPINB13', 'SNAI2', 'NKX2-1',
      'KRT6A', 'CD55', 'PKP1', 'SPINK1'
   )

   actual <- normalizeProbeIds(probe)

   expect_equal(rownames(actual), expected)
})
