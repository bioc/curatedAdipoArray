# load required libraries -----------------------------------------------------
library(tidyverse)
library(org.Mm.eg.db)
library(BiocGenerics)

# load and combine esets ------------------------------------------------------
# load metadata
md <- read_tsv('inst/extdata/curated_metadata.tsv')
genetic <- unique(md$series_id[md$perturbation_type != 'pharmacological'])
fls <- paste0('cleandata/', genetic, '.eSet.rds')
fls <- fls[file.exists(fls)]

# read clean esets in a list
eset_list <- map(fls, read_rds)

# combine esets
combined_eset <- do.call('combine', eset_list)

# save combined esets
write_rds(combined_eset, 'cleandata/genetic_perturbation.rds')

# load metadata
md <- read_tsv('inst/extdata/curated_metadata.tsv')
pharma <- unique(md$series_id[md$perturbation_type != 'genetic'])
fls <- paste0('cleandata/', pharma, '.eSet.rds')
fls <- fls[file.exists(fls)]

# read clean esets in a list
eset_list <- map(fls, read_rds)

# combine esets
combined_eset <- do.call('combine', eset_list)

# save combined esets
write_rds(combined_eset, 'cleandata/pharmacological_perturbation.rds')
