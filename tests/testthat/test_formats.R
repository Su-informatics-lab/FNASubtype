context("File Formats")


# CSV Files

test_that("CSV file GeneID column becomes row names", {
   csvfile <- system.file(file.path('testdata', 'sample.csv'), package=.PACKAGE_NAME)

   data <- loadCsvData(csvfile)

   expected <- c(
      '200801_x_at', '208695_s_at', '212869_x_at', '213583_x_at', '219795_at',
      '209800_at', 'POS_A', '203074_at', '209351_at', '214580_x_at',
      '217272_s_at', '221854_at', '201925_s_at', '206239_s_at', '207847_s_at',
      '209598_at', '211024_s_at', '212950_at', '219580_s_at', '201820_at',
      '209863_s_at', '213139_at'
   )

   expect_equal(rownames(data), expected)
})

test_that("CSV file header labels retained as column names", {
   csvfile <- system.file(file.path('testdata', 'sample.csv'), package=.PACKAGE_NAME)

   data <- loadCsvData(csvfile)

   expected <- c(
      'SuZKB', 'LpO3F', 'oNPzf', 'huWrt', 'Q8f1b',
      'vITSC', 'CYZKk', 'Hen6P', 'lA4Aq', 'F219O'
   )

   expect_equal(colnames(data), expected)
})
