#!/bin/bash
SCR=inst/scripts
LOG=log

all: $(LOG)/log-dir\
	$(LOG)/get-data \
	$(LOG)/clean-data \
	$(LOG)/merge-data \
	$(LOG)/test-data \
	$(LOG)/make-metadata

$(LOG)/log-dir:
	test ! -d $(LOG) && mkdir $(LOG) || exit 0
	echo "inst/log" created > $(LOG)/$(@F)

$(LOG)/get-data: $(SCR)/get-data.R \
	$(SCR)/curated_metadata.tsv
	R CMD BATCH --vanilla $< $(LOG)/$(@F)

$(LOG)/clean-data: $(SCR)/clean-data.R \
	$(SCR)/helper-functions.R \
	$(SCR)/curated_metadata.tsv \
	$(SCR)/gpl_symbols.tsv
	R CMD BATCH --vanilla $< $(LOG)/$(@F)

$(LOG)/merge-data: $(SCR)/merge-data.R \
	$(SCR)/curated_metadata.tsv
	R CMD BATCH --vanilla $< $(LOG)/$(@F)

$(LOG)/test-data: $(SCR)/test-data.R
	R CMD BATCH --vanilla $< $(LOG)/$(@F)

$(LOG)/make-metadata: $(SCR)/make-metadata.R
	R CMD BATCH --vanilla $< $(LOG)/$(@F)
