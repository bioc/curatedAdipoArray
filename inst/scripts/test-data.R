
library(testthat)
library(tidyverse)
library(Biobase)
library(org.Mm.eg.db)

context('test clean data')

test_that("clean data is formated properly.", {
    symbols <- keys(org.Mm.eg.db, 'SYMBOL')

    fls <- list.files(
      'cleandata',
      full.names = TRUE
    )

      esets <- map(fls, read_rds)

      expect_true(all(unlist(map(esets, ~class(.x) == 'ExpressionSet'))))
      expect_true(all(unlist(map(esets, ~nrow(pData(.x)) > 1))))
      expect_true(all(unlist(map(esets, ~ncol(pData(.x)) > 1))))
      expect_true(all(unlist(map(esets, ~ncol(exprs(.x)) > 1))))
      expect_true(all(unlist(map(esets, ~ncol(exprs(.x)) > 1))))
      expect_true(all(unlist(map(esets, ~length(intersect(rownames(.x), symbols)) > 100))))

})

test_that('combined data is formated properly.', {
  symbols <- keys(org.Mm.eg.db, 'SYMBOL')
  md <- read_tsv('inst/scripts/curated_metadata.tsv')

  eset <- read_rds('cleandata/genetic_perturbation.rds')

  expect_true(all(rownames(eset) %in% symbols))
  expect_true(all(colnames(eset) %in% md$sample_id))

  eset <- read_rds('cleandata/pharmacological_perturbation.rds')

  expect_true(all(rownames(eset) %in% symbols))
  expect_true(all(colnames(eset) %in% md$sample_id))
})
