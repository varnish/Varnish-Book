
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

${BDIR}/varnish_sysadmin.html: varnish_sysadmin.rst Makefile build ${BDIR}/version.rst
	/usr/bin/rst2s5 varnish_sysadmin.rst -r 5 --current-slide --theme-url=ui/vs/ ${BDIR}/varnish_sysadmin.html

${BDIR}/varnish_sysadmin.pdf: varnish_sysadmin.rst Makefile ui/pdf.style ${BDIR}/version.rst
	 ${RST2PDF} -s ui/pdf.style -b2 varnish_sysadmin.rst -o ${BDIR}/varnish_sysadmin.pdf

clean:
	@$(MAKE) -C img clean
	-rm -r build/

%.png: %.dot Makefile
	dot -Tpng < $< > $@

