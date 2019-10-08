# load required libraries
library(tidyverse)
library(Biobase)

fls <- list.files('cleandata',
                  pattern = 'GSE*',
                  full.names = TRUE)
names(fls) <- fls
md1 <- map(fls, function(x) {
    gse <- read_rds(x)
    as.data.frame(pData(gse))
  }) %>%
  bind_rows(.id = 'path')

md1 %>%
  group_by(series_id) %>%
  summarise(
    Title = paste0(
      "A Clean Expression Matrix of the GEO", unique(series_id), " Dataset."
    ),
    Description = paste0(
      "MDI-induced 3T3-L1 pre-adipocytes with ",
      paste0(unique(treatment_type), collapse = '/'),
      " treatment for ",
      paste0(unique(treatment_target), collapse = '/')
    ),
    BiocVersion = "3.9",
    Genome = 'mm10',
    SourceType = "GSEmatrix",
    SourceUrl = "https://github.com/MahShaaban/curatedAdipoArray",
    SourceVersion = "October 10 2019",
    Species = "Mus musculus",
    TaxonomyId = "10090",
    Coordinate_1_based = TRUE,
    DataProvider = "GEO",
    Maintainer = "Mahmoud Ahmed <mahmoud.s.fahmy@students.kasralainy.edu.eg>",
    RDataClass = "ExpressionSet",
    DispatchClass = "Rds",
    RDataPath = unique(path),
    Tags = "",
    Notes = ""
  ) %>%
  select(-series_id) %>%
  write_csv('inst/extdata/metadata.csv')

fls <- list.files('cleandata',
                  pattern = '*_perturbations*',
                  full.names = TRUE)

data.frame(path = fls) %>%
  mutate(
    type = str_split(path, '\\_|/', simplify = TRUE)[, 2],
    batch = ifelse(grepl('2', path), '(processed)', ''),
    Title = paste(
      "A Curated Microarrays Dataset", batch,"of MDI-induced",
      "Differentiated Adipocytes (3T3-L1) Under", type,"Perturbations"
    ),
    Description = paste(
      "A curated dataset", batch, "of Microarrays",
      "samples. The samples are MDI-induced pre-adipocytes (3T3-L1) at",
      "different time points/stage of differentiation under different types",
      "of", type,"perturbations."
    ),
    BiocVersion = "3.9",
    Genome = "mm10",
    SourceType = "GSEmatrix",
    SourceUrl = "https://github.com/MahShaaban/curatedAdipoChIP",
    SourceVersion = "October 10 2019",
    Species = "Mus musculus",
    TaxonomyId = "10090",
    Coordinate_1_based = TRUE,
    DataProvider = "GEO",
    Maintainer = "Mahmoud Ahmed <mahmoud.s.fahmy@students.kasralainy.edu.eg>",
    RDataClass = "ExpressionSet",
    DispatchClass = "Rds",
    RDataPath = path,
    Tags = "",
    Notes = ""
  ) %>%
  select(-path, -type, -batch) %>%
  write_csv('inst/extdata/metadata.csv', append = TRUE)
