# load required libraries -----------------------------------------------------
library(GEOquery)
library(WGCNA)
library(org.Mm.eg.db)
library(tidyverse)

source('inst/scripts/helper-functions.R')

# set options -----------------------------------------------------------------
allowWGCNAThreads(4)

# load metadata and annotation data -------------------------------------------
md <- read_tsv('inst/extdata/curated_metadata.tsv')
gpls_symbol <- read_tsv('inst/extdata/gpl_symbols.tsv')

# merge md and gpls_symbol
series_symbol <- md %>%
  filter(geo_missing != 1 & symbol_missing != 1) %>%
  dplyr::select(series_id, gpl) %>%
  unique() %>%
  left_join(gpls_symbol)

# get keys
symbols <- keys(org.Mm.eg.db, 'SYMBOL')

# clean and write expression sets ---------------------------------------------
## create directory
if(!dir.exists('cleandata')) {
  dir.create('cleandata')
}
## run clean_eset
map2(series_symbol$series_id, series_symbol$symbol_col,
     function(x, y) {
       try({
         # load eset
         gse <- getGEO(x,
                       destdir = 'rawdata')[[1]]

         # clean eset
         eset <- clean_eset(
             gse,
             md,
             y,
             symbols,
             collapse = TRUE
         )
         # write eset
         write_rds(eset,
                   path = paste0('cleandata/', x, '.eSet.rds'))
       })
     })
