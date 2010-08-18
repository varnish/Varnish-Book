
RST2PDF=/usr/local/bin/rst2pdf
BDIR=build

all: ${BDIR} ${BDIR}/ui ${BDIR}/img images ${BDIR}/varnish_sysadmin.html ${BDIR}/varnish_sysadmin.pdf

build/version.rst: *
	./version.sh > build/version.rst

images:
	@$(MAKE) -C img

${BDIR}/ui:
	ln -s ${PWD}/ui ./${BDIR}/ui

${BDIR}/img:
	ln -s ${PWD}/img ./${BDIR}/img

${BDIR}:
	mkdir -p ${BDIR}

${BDIR}/varnish_sysadmin.html: varnish_sysadmin.rst build ${BDIR}/version.rst
	/usr/bin/rst2s5 varnish_sysadmin.rst -r 5 --current-slide --theme-url=ui/vs/ ${BDIR}/varnish_sysadmin.html

${BDIR}/varnish_sysadmin.pdf: varnish_sysadmin.rst ui/pdf.style ${BDIR}/version.rst
	 ${RST2PDF} -s ui/pdf.style -b2 varnish_sysadmin.rst -o ${BDIR}/varnish_sysadmin.pdf

clean:
	@$(MAKE) -C img clean
	-rm -r build/

%.png: %.dot
	dot -Tpng < $< > $@

dist: all
	version=`./version.sh | grep :Version: | sed 's/:Version: //' | tr -d '()[] '`;\
	echo $$version; \
	target=${BDIR}/dist/varnish_sysadmin-$$version/; \
	echo $$target ;\
	mkdir -p $${target};\
	mkdir -p $$target/html/;\
	mkdir -p $$target/pdf/;\
	cp -r ${BDIR}/varnish_sysadmin.html $$target/html/;\
	cp -rL ${BDIR}/ui $$target/html/;\
	cp -rL ${BDIR}/img $$target/html/;\
	cp -r ${BDIR}/varnish_sysadmin.pdf $$target/pdf/varnish_sysadmin-v$$version.pdf;\
	cp -r munin/ $$target;\
	cp NEWS $$target;\
	rm -r $${target}/html/img/staging/;\
	rm -r $${target}/html/img/*.dot;\
	rm -r $${target}/html/img/Makefile;\
	tar -hC ${BDIR}/dist/ -cjf varnish_sysadmin-$$version.tar.bz2 varnish_sysadmin-$$version/
