# load required libraries -----------------------------------------------------
library(tidyverse)
library(SummarizedExperiment)

# clean and write expression sets ---------------------------------------------
## create directory
if(!dir.exists('clean_se')) {
  dir.create('clean_se')
}

## transform expression sets to summarized experiments
fls <- list.files('cleandata', full.names = TRUE)
names(fls) <- str_split(fls, '/|\\.', simplify = TRUE)[, 2]

imap(fls, function(x, .y) {
  eset <- read_rds(x)
  write_rds(makeSummarizedExperimentFromExpressionSet(eset),
            path = paste0('clean_se/', .y, '.rds'))
})
