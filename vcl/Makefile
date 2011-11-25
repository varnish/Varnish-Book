
SHELL = /bin/sh 
vcls = *.vcl

check: $(vcls)
	@for a in $(vcls); do \
		echo -n Testing $$a... ;\
		if egrep -q '^(backend|director)' $$a; then \
			foo=`varnishd -n $$PWD/../build/ -C -f $$a 2>&1 > /dev/null` ;\
			if [ -z "$$foo" ]; then \
				echo "OK"; \
			 else \
				echo "failed"; \
				echo "$$foo"; \
				exit 1; \
			 fi;\
		else \
			test -e $$a.tmp && exit 2;\
			cat backend.vcl $$a > $$a.tmp; \
			foo=`varnishd -C -n $$PWD/../build/ -f $$a.tmp 2>&1 > /dev/null` ;\
			rm $$a.tmp ; \
			if [ -z "$$foo" ]; then \
				echo "OK"; \
			 else \
				echo "failed"; \
				echo "$$foo"; \
				exit 1;\
			 fi; \
		fi;\
	done

.PHONY: check

