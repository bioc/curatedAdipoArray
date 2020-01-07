#!/bin/bash
SCR=inst/scripts
EXT=inst/extdata
LOG=log

all: $(LOG)/log-dir \
	$(LOG)/get-data \
	$(LOG)/clean-data \
	$(LOG)/merge-data \
	$(LOG)/batch-data \
	$(LOG)/test-data \
	$(LOG)/make-se \
	$(LOG)/make-metadata

$(LOG)/log-dir:
	test ! -d $(LOG) && mkdir $(LOG) || exit 0
	echo "inst/log" created > $(LOG)/$(@F)

$(LOG)/get-data: $(SCR)/get-data.R \
	$(EXT)/curated_metadata.tsv
	R CMD BATCH --vanilla $< $(LOG)/$(@F)

$(LOG)/clean-data: $(SCR)/clean-data.R \
	$(SCR)/helper-functions.R \
	$(EXT)/curated_metadata.tsv \
	$(EXT)/gpl_symbols.tsv
	R CMD BATCH --vanilla $< $(LOG)/$(@F)

$(LOG)/merge-data: $(SCR)/merge-data.R \
	$(EXT)/curated_metadata.tsv
	R CMD BATCH --vanilla $< $(LOG)/$(@F)

$(LOG)/batch-data: $(SCR)/batch-data.R
	R CMD BATCH --vanilla $< $(LOG)/$(@F)

$(LOG)/test-data: $(SCR)/test-data.R
	R CMD BATCH --vanilla $< $(LOG)/$(@F)

$(LOG)/make-se: $(SCR)/make-se.R
	R CMD BATCH --vanilla $< $(LOG)/$(@F)

$(LOG)/make-metadata: $(SCR)/make-metadata.R
	R CMD BATCH --vanilla $< $(LOG)/$(@F)
