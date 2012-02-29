
SHELL = /bin/sh 
vcls = *.vcl

objs = $(addsuffix .done,$(basename $(notdir $(wildcard *vcl))))

%.done: %.vcl
	@if egrep -q '^(backend|director)' $<; then \
		foo=`varnishd -n $$PWD/../build/ -C -f $< 2>&1 > /dev/null` ;\
		if [ -z "$$foo" ]; then \
			echo "VCL OK: $<"; \
		 else \
			echo "VCL FAILED: $<"; \
			echo "$$foo"; \
			exit 1; \
		 fi;\
	else \
		test -e $<.tmp && exit 2;\
		cat backend.vcl $< > $<.tmp; \
		foo=`varnishd -C -n $$PWD/../build/ -f $<.tmp 2>&1 > /dev/null` ;\
		rm $<.tmp ; \
		if [ -z "$$foo" ]; then \
			echo "VCL OK: $<"; \
		 else \
			echo "VCL FAILED: $<"; \
			echo "$$foo"; \
			exit 1;\
		 fi; \
	fi;\
	

check: $(objs)
	

.PHONY: check

