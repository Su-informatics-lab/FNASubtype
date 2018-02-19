loadCsvData <- function(filename, sep=',', geneColumn='GeneID') {
   data <- read.csv(filename, head=T, sep=sep, row.names=geneColumn)

   data
}


loadGctData <- function(filename) {
   data <- read.delim(filename, skip=2, row.names='NAME')

   ## Drop the "Description" column
   data <- data[, -1]

   data
}
