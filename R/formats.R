loadCsvData <- function(filename, sep=',', geneColumn='GeneID') {
   data <- read.csv(filename, head=T, sep=sep, row.names=geneColumn)

   data
}
