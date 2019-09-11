# load libraries --------------------------------------------------------------
library(tidyverse)
library(GEOquery)

# load data -------------------------------------------------------------------
md <- read_tsv('inst/scripts/curated_metadata.tsv')

# download gse matrices -------------------------------------------------------
## create directory
if(!dir.exists('rawdata')) {
  dir.create('rawdata')
}

map(unique(md$series_id), function(x) {
  if (!file.exists(paste0('rawdata/', x,'_series_matrix.txt.gz'))) {
    getGEO(x,
           destdir = 'rawdata/',
           GSEMatrix = TRUE)
    return(NULL)
  }
})
