
SHELL = /bin/sh 
phps = webdev/*.php

objs = $(addsuffix .done,$(basename $(notdir $(wildcard webdev/*.php))))

# This is probably a bit too basic

%.done: webdev/%.php
	@if ! php5 -l -f $< >/dev/null; then \
		echo "Material FAILED: $<"; \
		php5 -l -f $< ;\
	else \
		echo "Material OK: $<"; \
	fi
	
check: $(objs)


.PHONY: check
