
RST2PDF=/usr/bin/rst2pdf
RST2S5=/usr/local/bin/rst2s5.py
BDIR=build

htmltarget=${BDIR}/varnish_sysadmin.html
pdftarget=${BDIR}/varnish_sysadmin.pdf
pdftargetslide=${BDIR}/varnish_sysadmin_slide.pdf
pdftargetteach=${BDIR}/varnish_sysadmin_teacher.pdf
rstsrc=varnish_sysadmin.rst
images = ui/img/vcl.png
common = ${rstsrc} ${BDIR}/version.rst ${images} vcl/* util/*

all: ${pdftarget} ${htmltarget} ${pdftargetteach} ${pdftargetslide}

mrproper: clean all

${BDIR}/version.rst: util/version.sh ${rstsrc}
	mkdir -p ${BDIR}
	./util/version.sh > ${BDIR}/version.rst

ui/img/%.png: ui/img/%.dot
	dot -Tpng < $< > $@

ui/img/%.svg: ui/img/%.dot
	dot -Tsvg < $< > $@

${BDIR}/ui:
	mkdir -p ${BDIR}
	ln -s ${PWD}/ui ./${BDIR}/ui

${BDIR}/img:
	mkdir -p ${BDIR}
	ln -s ${PWD}/ui/img ./${BDIR}/img

${BDIR}:
	mkdir -p ${BDIR}

${htmltarget}: ${common} ${BDIR}/img ${BDIR}/ui ui/vs/*
	${RST2S5} ${rstsrc} -r 5 --strip-elements-with-class=onlypdf --current-slide --theme-url=ui/vs/ ${htmltarget}

${pdftarget}: ${common} ui/pdf.style
	 ${RST2PDF} -s ui/pdf.style -b2 ${rstsrc} -o ${pdftarget}

${pdftargetslide}: ${common} ui/pdf_slide.style
	 ./util/strip-class.gawk ${rstsrc} | ${RST2PDF} -s ui/pdf_slide.style -b2 -o ${pdftargetslide}

${pdftargetteach}: ${common} ui/pdf.style
	 awk '$$0 == ".." { print ".. admonition:: Instructor comment"; $$0=""; } { print }' ${rstsrc}  |  ${RST2PDF} -s ui/pdf.style -b2 -o ${pdftargetteach}

clean:
	-rm -r build/

dist: all
	version=`./util/version.sh | grep :Version: | sed 's/:Version: //' | tr -d '()[] '`;\
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
	cp -r ${BDIR}/varnish_sysadmin_teacher.pdf $$target/pdf/varnish_sysadmin_teacher-v$$version.pdf;\
	cp -r munin/ $$target;\
	cp NEWS $$target;\
	rm -r $${target}/html/img/staging/;\
	rm -r $${target}/html/img/*.dot;\
	tar -hC ${BDIR}/dist/ -cjf varnish_sysadmin-$$version.tar.bz2 varnish_sysadmin-$$version/

check:
	$(MAKE) -C vcl/

.PHONY: all mrproper clean
