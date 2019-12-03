# load libraries --------------------------------------------------------------
library(tidyverse)
library(GEOquery)

# load data -------------------------------------------------------------------
md <- read_tsv('inst/extdata/curated_metadata.tsv')

# download gse matrices -------------------------------------------------------
## create directory
if(!dir.exists('rawdata')) {
    dir.create('rawdata')
}

# download data from GEO
map(unique(md$series_id), function(x) {
    getGEOfile(x,
               destdir = 'rawdata/')
    return(NULL)
})
