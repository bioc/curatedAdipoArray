#' Clean Gene Symbols
#'
#' Take a string from GPL gene symbol or assignment columns and return gene
#' symbols that matches the input symbols
#'
#' @param string A character string or a character vector
#' @param symbols A character string or a character vector
#'
#' @return A character vector
#' @export
clean_symbols <- function(string, symbols) {
  # split the input string
  symbol_mat <- stringr::str_split(string,
                                   pattern = ' // | /// ',
                                   simplify = TRUE)

  # match columns in the returned matrix by symbols
  ind <- apply(symbol_mat, 2, function(x) sum(x %in% symbols))

  # extract the column index with the most matches
  col <- which.max(unlist(ind))

  # unlist the matrix column
  res <- unlist(symbol_mat[, col])

  # change the unmatched symbols to NA
  res <- ifelse(res %in% symbols, res, NA)

  # return
  return(res)
}

#' Clean ExpressionSet object
#'
#' Take an ExpressionSet object and clean it by adding phenotype data that
#' matches the input md and use gene symbols as row names in the matrix.
#'
#' @param gse An ExpressionSet object
#' @param md A data.frame
#' @param symbol_col A character string
#' @param symbols A character vector
#' @param collapse A logical
#'
#' @return An ExpressionSet object
#'
#' @export
clean_eset <- function(gse, md, symbol_col, symbols, collapse = FALSE) {
    # match eset columns with md rows
    ind <- match(colnames(gse), md$sample_id)
    ind <- ind[!is.na(ind)]

    # subset md and rename rows
    pd <- as.data.frame(md[ind,])
    rownames(pd) <- pd$sample_id

    # get fd
    fd <- fData(gse)
    cs <- clean_symbols(unlist(fd[, symbol_col]),
                        symbols = symbols)

    # subset eset to probes with symbols
    e <- gse[!is.na(cs), colnames(gse) %in% pd$sample_id]

    # get matrix
    mat <- Biobase::exprs(e)

    # remove NA from symbols vector
    cs <- cs[!is.na(cs)]


    # collapse, if true
    if(collapse) {
      mat <- WGCNA::collapseRows(
        mat,
        rowGroup = cs,
        rowID = rownames(mat)
      )[[1]]
    }

    # build eset
    eset <- Biobase::ExpressionSet(mat,
                                   phenoData = new('AnnotatedDataFrame', pd))

    # return eset
    return(eset)
}

#' Remove a given batche effect from an ExpressionSet
#'
#' @param eset An ExpressionSet object
#' @param remove_na A logical
#' @param filter  A logical
#' @param normalize  A logical
#'
#' @return An ExpressionSet object
#'
#' @export
remove_batch <- function(eset, batch, remove_na = TRUE, filter = TRUE,
                         normalize = TRUE) {
  # get expression data
  mat <- Biobase::exprs(eset)

  # remove NA
  if (remove_na) {
    ind <- apply(mat, 1, function(x) sum(is.na(x)))
    mat <- mat[ind == 0,]
  }

  # filter low intensities
  if (filter) {
    mat[mat < 0] <- 0
    mat <- mat[rowMeans(mat) > 10,]
  }

  # normalize
  if (normalize) {
    mat <- limma::normalizeBetweenArrays(log2(mat + 1))
  }

  # remove batch
  mat <- sva::ComBat(mat,
                     batch = batch)

  # return
  newset <- ExpressionSet(mat,
                          phenoData = phenoData(eset))
  return(newset)
}
