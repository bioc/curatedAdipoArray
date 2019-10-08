[![Travis build status](https://travis-ci.org/MahShaaban/curatedAdipoArray.svg?branch=master)](https://travis-ci.org/MahShaaban/curatedAdipoArray)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/MahShaaban/curatedAdipoArray?branch=master&svg=true)](https://ci.appveyor.com/project/MahShaaban/curatedAdipoArray)

# curatedAdipoArray

A Curated Microarrays Dataset of MDI-induced Differentiated Adipocytes (3T3-L1)
Under Genetic and Pharmacological Perturbations

# Overview

A curated dataset of Microarrays samples. The samples are MDI-induced pre-
adipocytes (3T3-L1) at different time points/stage of differentiation under 
different types of genetic (knockdown/overexpression) and pharmacological 
(drug treatment). The package documents the data collection and processing.
In addition to the documentation, the package contains the scripts that was
used to generated the data.

# Introduction

## What is `curatedAdipoArray`?

This package is for documenting and distributing a curated dataset of gene 
expression from MDI-induced 3T3-L1 adipocyte cell model under genetic and
pharmacological modification.

## What is contained in `curatedAdipoArray`?

The package contains two things:

1. Scripts for documenting and reproducing the dataset in `inst/scripts`.
2. Access to the clean and the processed data `ExpressionSet` objects through
`ExperimentHub`.

## What is `curatedAdipoArray` for?

The data contained in the package can be used in any number of downstream
analysis such as differential expression and gene set enrichment.

# Installation

The `curatedAdipoArray` package can be installed from Bioconductor using 
`BiocManager`.

```{r install_biocmanager,eval=FALSE}
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("curatedAdipoArray")
```

# Docker image

The pre-processing and processing of the data setup environment is available as
a `docker` image. This image is also suitable for reproducing this document. 
The `docker` image can be obtained using the `docker` CLI client.

```
$ docker pull bcmslab/adiporeg_array:latest
```

# Citing `curatedAdipoArray`

To cite the package use:

```{r citation, eval=FALSE}
# citing the package
citation("curatedAdipoArray")
```
