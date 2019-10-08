# load library
library(tidyverse)
library(Biobase)
library(sva)

source('inst/scripts/helper-functions.R')

# load data and remove batch
genetic <- read_rds('cleandata/genetic_perturbation.rds')
genetic2 <- remove_batch(genetic,
                         batch = paste0(genetic$gpl, genetic$series_id))
write_rds(genetic2, 'cleandata/genetic_perturbation2.rds')

pharma <- read_rds('cleandata/pharmacological_perturbation.rds')
pharma2 <- remove_batch(pharma,
                        batch = paste0(pharma$gpl, pharma$series_id))
write_rds(pharma2, 'cleandata/pharmacological_perturbation2.rds')
