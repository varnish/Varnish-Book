
RST2PDF=/usr/local/bin/rst2pdf
BDIR=build

htmltarget=${BDIR}/varnish_sysadmin.html
pdftarget=${BDIR}/varnish_sysadmin.pdf
rstsrc=varnish_sysadmin.rst
images = img/vcl.png
common = ${rstsrc} ${BDIR}/version.rst ${images} vcl/*

all: ${pdftarget} ${htmltarget}

${BDIR}/version.rst: version.sh ${rstsrc}
	mkdir -p ${BDIR}
	./version.sh > ${BDIR}/version.rst

img/%.png: img/%.dot
	dot -Tpng < $< > $@

img/%.svg: img/%.dot
	dot -Tsvg < $< > $@

${BDIR}/ui:
	mkdir -p ${BDIR}
	ln -s ${PWD}/ui ./${BDIR}/ui

${BDIR}/img:
	mkdir -p ${BDIR}
	ln -s ${PWD}/img ./${BDIR}/img

${BDIR}:
	mkdir -p ${BDIR}

${htmltarget}: ${common} ${BDIR}/img ${BDIR}/ui ui/vs/*
	/usr/bin/rst2s5 ${rstsrc} -r 5 --current-slide --theme-url=ui/vs/ ${htmltarget}

${pdftarget}: ${common} ui/pdf.style
	 ${RST2PDF} -s ui/pdf.style -b2 ${rstsrc} -o ${pdftarget}

clean:
	-rm -r build/

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
	tar -hC ${BDIR}/dist/ -cjf varnish_sysadmin-$$version.tar.bz2 varnish_sysadmin-$$version/

check:
	$(MAKE) -C vcl/

.PHONY: all
