# TODO: Update the data to name the genes using the identifiers Jing suggested

getCoefficients <- function() {
   filepath <- system.file("extdata", 'coefficients.rda', package=.PACKAGE_NAME)
   varName <- load(filepath)

   get(varName)
}

getAnnotations <- function() {
   filepath <- system.file("extdata", 'annotations.csv', package=.PACKAGE_NAME)

   read.csv(filepath)
}

getHousekeepingGenes <- function() {
   hkg <- getAnnotations()

   hkg[hkg$Gene.Selection == 'HK4/6', ]
}
