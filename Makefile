RST2PDF=/usr/bin/rst2pdf
BDIR=build
CACHECENTERC=../varnish-cache/bin/varnishd/cache_center.c
pdftarget=${BDIR}/varnish_tutorial.pdf
pdftargetslide=${BDIR}/varnish_tutorial_slide.pdf
pdftargetsysadmin=${BDIR}/varnish_sysadmin.pdf
pdftargetslidesysadmin=${BDIR}/varnish_sysadmin_slide.pdf
pdftargetdev=${BDIR}/varnish_dev.pdf
pdftargetslidedev=${BDIR}/varnish_dev_slide.pdf
rstsrc=varnish_sysadmin.rst
images = ui/img/vcl.png ui/img/request.png
common = ${rstsrc} ${BDIR}/version.rst ${images} vcl/* util/control.rst util/frontpage.rst util/printheaders.rst
PICK = "./util/pickchapter.sh"
ALL = "Introduction,Getting started,Tuning,HTTP,VCL Basics,VCL functions,Cache invalidation,Saving a request,AJAX,Cookies,ESI,Varnish Programs,Finishing words"
SYSADMIN = "Introduction,Getting started,Tuning,VCL Basics,VCL functions,Cache invalidation,Saving a request,Varnish Programs,Finishing words"
WEBDEV = "Introduction,Getting started,HTTP,VCL Basics,VCL functions,Cache invalidation,AJAX,Cookies,ESI,Finishing words"

all: ${pdftarget} ${pdftargetslide} ${pdftargetsysadmin} ${pdftargetslidesysadmin} ${pdftargetdev} ${pdftargetslidedev}

mrproper: clean all

${BDIR}/version.rst: util/version.sh ${rstsrc}
	mkdir -p ${BDIR}
	./util/version.sh > ${BDIR}/version.rst

ui/img/%.png: ui/img/%.dot
	dot -Gsize=2000,3000 -Tpng < $< > $@

ui/img/%.svg: ui/img/%.dot
	dot -Tsvg < $< > $@

flowchartupdate:
	sed -n '/^DOT/s///p' ${CACHECENTERC} > ui/img/request.dot

${BDIR}/ui:
	mkdir -p ${BDIR}
	ln -s ${PWD}/ui ./${BDIR}/ui

${BDIR}/img:
	mkdir -p ${BDIR}
	ln -s ${PWD}/ui/img ./${BDIR}/img

${BDIR}:
	mkdir -p ${BDIR}

# I WOULD LIKE TO SAY: I HATE MYSELF!

${pdftarget}: ${common} ui/pdf.style
	${PICK} ${ALL} | ${RST2PDF} -s ui/pdf.style -b2 -o ${pdftarget}

${pdftargetslide}: ${common} ui/pdf_slide.style
	${PICK} ${ALL} | ./util/strip-class.gawk | ${RST2PDF} -s ui/pdf_slide.style -b2 -o ${pdftargetslide}

${pdftargetsysadmin}: ${common} ui/pdf.style
	${PICK} ${SYSADMIN} | ${RST2PDF} -s ui/pdf.style -b2 -o ${pdftargetsysadmin}

${pdftargetslidesysadmin}: ${common} ui/pdf_slide.style
	${PICK} ${SYSADMIN} | ./util/strip-class.gawk | ${RST2PDF} -s ui/pdf_slide.style -b2 -o ${pdftargetslidesysadmin}

${pdftargetdev}: ${common} ui/pdf.style
	${PICK} ${WEBDEV} | ${RST2PDF} -s ui/pdf.style -b2 -o ${pdftargetdev}

${pdftargetslidedev}: ${common} ui/pdf_slide.style
	${PICK} ${WEBDEV} | ./util/strip-class.gawk | ${RST2PDF} -s ui/pdf_slide.style -b2 -o ${pdftargetslidedev}

util/param.rst:
	( sleep 2; echo param.show ) | varnishd -n /tmp/meh -a localhost:2211 -d | gawk -v foo=0 '(foo == 2) && (/^[a-z]/) {  printf ".. |default_"$$1"| replace:: "; gsub($$1,""); print; } /^200 / { foo++;}' > util/param.rst

sourceupdate: util/param.rst flowchartupdate


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
	mkdir -p $$target/pdf/;\
	cp -r ${BDIR}/varnish_sysadmin.pdf $$target/pdf/varnish_sysadmin-v$$version.pdf;\
	cp -r munin/ $$target;\
	cp NEWS $$target;\
	tar -hC ${BDIR}/dist/ -cjf varnish_sysadmin-$$version.tar.bz2 varnish_sysadmin-$$version/

check:
	$(MAKE) -C vcl/

.PHONY: all mrproper clean sourceupdate flowchartupdate util/param.rst
