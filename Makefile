RST2PDF=/usr/bin/rst2pdf
BDIR=build
CACHECENTERC=../varnish-cache/bin/varnishd/cache_center.c
PICK = "./util/pickchapter.sh"

# The following are chapter lists for the relevant versions of the PDFs.
# Please note that they need to be exact. No extra spaces, case sensitive
# etc.
# 
# If you want a new set, just make a new variable and that's the name of
# the pdfs you can now build.

tutorial = "Introduction,Getting started,Tuning,HTTP,VCL Basics,VCL functions,Cache invalidation,Saving a request,AJAX,Cookies,ESI,Varnish Programs,Finishing words"
sysadmin = "Introduction,Getting started,Tuning,VCL Basics,VCL functions,Cache invalidation,Saving a request,Varnish Programs,Finishing words"
webdev = "Introduction,Getting started,HTTP,VCL Basics,VCL functions,Cache invalidation,AJAX,Cookies,ESI,Finishing words"

webdevt = ${BDIR}/varnish-webdev.pdf ${BDIR}/varnish_slide-webdev.pdf
sysadmint = ${BDIR}/varnish-sysadmin.pdf ${BDIR}/varnish_slide-sysadmin.pdf
tutorialt = ${BDIR}/varnish-tutorial.pdf ${BDIR}/varnish_slide-tutorial.pdf
rstsrc=varnish_tutorial.rst
images = ui/img/vcl.png ui/img/request.png
common = ${rstsrc} ${BDIR}/version.rst ${images} vcl/* util/control.rst util/frontpage.rst util/printheaders.rst material/webdev/*

all: webdev tutorial sysadmin

webdev: ${webdevt}

sysadmin: ${sysadmint}

tutorial: ${tutorialt}


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

${BDIR}/varnish-%.pdf: ${common} ui/pdf.style
	${PICK} ${$*} | ${RST2PDF} -s ui/pdf.style -b2 -o $@

${BDIR}/varnish_slide-%.pdf: ${common} ui/pdf_slide.style
	${PICK} ${$*} | ./util/strip-class.gawk | ${RST2PDF} -s ui/pdf_slide.style -b2 -o $@

util/param.rst:
	( sleep 2; echo param.show ) | varnishd -n /tmp/meh -a localhost:2211 -d | gawk -v foo=0 '(foo == 2) && (/^[a-z]/) {  printf ".. |default_"$$1"| replace:: "; gsub($$1,""); print; } /^200 / { foo++;}' > util/param.rst

sourceupdate: util/param.rst flowchartupdate

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
	@ret=0; for a in vcl/*.vcl; do \
		grep -q $$a ${rstsrc} || { ret=1; echo "$$a is a file, but not included in the rst"; }; \
	done; \
	exit $$ret

.PHONY: all mrproper clean sourceupdate flowchartupdate util/param.rst webdev sysadmin tutorial
