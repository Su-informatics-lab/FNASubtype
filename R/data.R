getCoefficients <- function() {
   filepath <- system.file("extdata", 'coefficients.rda', package=.PACKAGE_NAME)
   varName <- load(filepath)

   get(varName)
}
