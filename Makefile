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

tutorial = "*"
sysadmin = "Introduction,Getting started,Tuning,VCL Basics,VCL functions,Cache invalidation,Saving a request,Varnish Programs,Finishing words"
webdev = "Introduction,Getting started,HTTP,VCL Basics,VCL functions,Cache invalidation,Content Composition,Finishing words"

webdevt = ${BDIR}/varnish-webdev.pdf ${BDIR}/varnish_slide-webdev.pdf
sysadmint = ${BDIR}/varnish-sysadmin.pdf ${BDIR}/varnish_slide-sysadmin.pdf
tutorialt = ${BDIR}/varnish-tutorial.pdf ${BDIR}/varnish_slide-tutorial.pdf
materialpath = www_examples
rstsrc =varnish_tutorial.rst
images = ui/img/vcl.png ui/img/request.png
common = ${rstsrc} \
	 ${BDIR}/version.rst \
	 ${images} \
	 vcl/*.vcl \
	 util/control.rst \
	 util/frontpage.rst \
	 util/printheaders.rst \
	 material/webdev/*

version = $(subst version-,,$(shell git describe --always --dirty))
versionshort = $(subst version-,,$(shell git describe --always --abbrev=0))

targets = webdev tutorial sysadmin

all: ${targets}

webdev: ${webdevt}

sysadmin: ${sysadmint}

tutorial: ${tutorialt}

src/conf.py: src/conf.py.in build/version.rst
	sed 's/@@VERSION@@/${version}/g; s/@@SHORTVERSION@@/${versionshort}/g;' < $< > $@
		
sphinx: ${common} src/conf.py
	mkdir -p src/util
	mkdir -p src/build
	for a in ui util/* vcl material build/version.rst ; do \
		if [ ! -e src/$$a ]; then \
			ln -s ${PWD}/$$a src/$$a ;\
		fi; \
	done;
	for a in src/util/frontpage.rst src/util/printheaders.rst; do \
		rm $$a; \
		touch $$a; \
	done
	util/splitchapters.sh ${rstsrc} src/
	sed -i 's/\.\. class:: handout//' src/*.rst
	sphinx-build -b html -d build/doctrees   src/ build/html

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
	@mkdir -p ${BDIR}
	@ln -s ${PWD}/ui ./${BDIR}/ui

${BDIR}/img:
	@mkdir -p ${BDIR}
	@ln -s ${PWD}/ui/img ./${BDIR}/img

${BDIR}:
	@mkdir -p ${BDIR}

${BDIR}/varnish-%.pdf: ${common} ui/pdf.style
	@echo Building PDFs for $*...
	@${PICK} ${$*} | ${RST2PDF} -s ui/pdf.style -b2 -o $@

${BDIR}/varnish_slide-%.pdf: ${common} ui/pdf_slide.style
	@echo Building PDF slides for $*...
	@${PICK} ${$*} | ./util/strip-class.gawk | ${RST2PDF} -s ui/pdf_slide.style -b2 -o $@

util/param.rst:
	( sleep 2; echo param.show ) | varnishd -n /tmp/meh -a localhost:2211 -d | gawk -v foo=0 '(foo == 2) && (/^[a-z]/) {  printf ".. |default_"$$1"| replace:: "; gsub($$1,""); print; } /^200 / { foo++;}' > util/param.rst

sourceupdate: util/param.rst flowchartupdate

clean:
	-rm -r build/

varnish_%-${version}.tar.bz2: check ${BDIR}/varnish-%.pdf ${BDIR}/varnish_slide-%.pdf ${BDIR}/${materialpath}.tar.bz2
	@echo Preparing $@ ...
	@target=${BDIR}/dist/varnish_$*-${version}/; \
	mkdir -p $${target};\
	mkdir -p $$target/pdf/;\
	cp -r ${BDIR}/varnish-$*.pdf $$target/pdf/varnish_$*-v${version}.pdf;\
	cp -r munin/ $$target;\
	cp -r ${BDIR}/${materialpath}.tar.bz2 $$target; \
	cp NEWS ${rstsrc} README.rst LICENSE $$target;\
	tar -hC ${BDIR}/dist/ -cjf $@ varnish_$*-${version}/

dist: $(addprefix varnish_,$(addsuffix -${version}.tar.bz2,${targets}))

material/webdev/index.html: material/webdev/index.rst
	rst2html $< > $@

${BDIR}/${materialpath}.tar.bz2: material/webdev/index.html ${BDIR} material/ material/webdev/*
	-rm -r ${BDIR}/${materialpath}
	mkdir -p ${BDIR}/${materialpath}
	cp -a material/webdev/* ${BDIR}/${materialpath}
	tar -hC ${BDIR}/ -cjf $@ ${materialpath}
	
vclcheck:
	@$(MAKE) -C vcl/

materialcheck:
	@$(MAKE) -C material/

check: vclcheck materialcheck
	@ret=0; for a in `ls -1 vcl/*.vcl material/webdev/*.php material/webdev/*.html | grep -v index`; do \
		grep -q $$a ${rstsrc} || { ret=1; echo "$$a is a file, but not included in the rst"; }; \
	done; \
	exit $$ret

.PHONY: all mrproper clean sourceupdate flowchartupdate util/param.rst ${targets} vclcheck materialcheck
