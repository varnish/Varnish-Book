RST2PDF=/usr/bin/rst2pdf
BDIR=build
#CACHECENTERC is not in Varnish-Cache-Plus github
#CACHECENTERC=../varnish-cache/bin/varnishd/cache_center.c
PICK = "./util/pickchapter2.igawk"

pdf_slide_style = ui/pdf_slide.style
pdf_style = ui/pdf.style

# The following are chapter lists for the relevant versions of the PDFs.
# Please note that they need to be exact. No extra spaces, case sensitive
# etc.
# 
# If you want a new set, just make a new variable and that's the name of
# the pdfs you can now build.

book = "*"
slides = "*"
slides-A4 = "*"

#"Introduction,Design Principles,Getting Started,Examining Data Provided by Varnish,Tuning,HTTP,VCL Basics,VCL Built-in Subroutines,Cache Invalidation,Saving a Request,Content Composition,Varnish Plus Software Components,Appendix A: Resources,Appendix B: Varnish Programs,Appendix C: Extra Material,Appendix D: From Varnish 3 to Varnish 4,Appendix E: Varnish Three Letter Acronyms"

# Selecting chapters in this way does not work.
# The script Varnish-Book/util/pickchapter2.igawk unsort them until the third chapter.

# TOFIX: sysadmin and webdev targets do not compiling as expected.
# sysadmin = "Abstract,Preface,Introduction,Getting\ started,The\ Varnish\ Log,Tuning,VCL\ Basics,VCL\ built-in\ subroutines,Cache\ invalidation,Appendix\ A:\ Vanish\ Programs"
# sysadmint = ${BDIR}/varnish-sysadmin.pdf ${BDIR}/varnish_slide-sysadmin.pdf
# webdev = "Introduction,Getting started,HTTP,VCL Basics,VCL functions,Cache invalidation,Content Composition,Finishing words"
# webdevt = ${BDIR}/varnish-webdev.pdf ${BDIR}/varnish_slide-webdev.pdf

bookt= ${BDIR}/varnish-book.pdf
slidest= ${BDIR}/varnish_slides.pdf
slides-A4t=${BDIR}/varnish_slides-A4.pdf
testt=${BDIR}/varnish-test.pdf ${BDIR}/varnish_slide-test.pdf
rstsrc =varnish_book.rst
images = ui/img/simplified_fsm.svg ui/img/simplified_fsm.pdf ui/img/detailed_fsm.svg ui/img/detailed_fsm.pdf ui/img/detailed_fsm_backend.svg
mergedrst = ${BDIR}/merged_book.rst

common = ${mergedrst} \
	 ${rstsrc} \
	 ${BDIR}/version.rst \
	 ${images} \
	 Makefile \
	 vcl/*.vcl \
	 vtc/*.vtc \
	 util/control.rst \
	 #${exercises_complete} \
	 ${exercises_stuff} \
	 material/webdev/*

bookutil =  util/frontpage.rst \
	    util/printheaders.rst

version = $(subst version-,,$(shell git describe --always --dirty))
versionshort = $(subst version-,,$(shell git describe --always --abbrev=0))

targets = book slides sphinx

all: ${common} ${bookutil} ${targets}

webdev: ${webdevt}

# sysadmin: ${sysadmint}

book: ${bookt}

slides: ${slidest}

slides-A4: ${slides-A4t}

test: ${testt}

src/conf.py: src/conf.py.in ${BDIR}/version.rst
	sed 's/@@VERSION@@/${version}/g; s/@@SHORTVERSION@@/${versionshort}/g;' < $< > $@

sphinx: ${common} src/conf.py
	for a in util/* vcl vtc material build/version.rst ; do \
		if [ ! -e src/$$a ]; then \
			ln -s ${PWD}/$$a src/$$a ;\
		fi; \
	done;

#Splits chapters into individual files, and creates the index page for sphinx.
	mkdir -p build/chapters
	ln -sf ../../ui build/chapters/
	mkdir -p build/html/chapters
	ln -sf ../_images build/html/chapters/

#update references in tables:
	mkdir -p src/chapters/tables
	rm -rf src/chapters/tables/*
	for a in tables/*; do \
		util/rst2sphinxparser_tables.awk -v dst="src/chapters/"$$a < ${PWD}/$$a; \
	done;

	util/rst2sphinxparser.igawk -v dst=${PWD}/src/ < ${mergedrst}

#Removes '.. class:: handout' from src/*.rst
	sed -i 's/\.\. class:: handout//' src/*.rst

	mkdir -p build/html/_images/
	cp ui/img/download_book*.jpg build/html/_images/

#	sphinx-build -b html -d build/doctrees src/ build/html
	@$(MAKE) -C src/ html
#	@$(MAKE) -C src/ epub

mrproper: clean all

.git/COMMIT_EDITMSG:
	touch .git/COMMIT_EDITMSG

${mergedrst}: ${BDIR} ${rstsrc} ${BDIR}/version.rst util/frontpage.rst
	util/parse.pl < ${rstsrc} > $@

${BDIR}/version.rst: util/version.sh ${mergedrst} .git/COMMIT_EDITMSG

	mkdir -p ${BDIR}
	./util/version.sh > ${BDIR}/version.rst

ui/img/%.svg: ui/img/%.dot
	dot -Tsvg < $< > $@

ui/img/%.pdf: ui/img/%.dot
	dot -Tpdf < $< > $@

#flowchartupdate:
#	sed -n '/^DOT/s///p' ${CACHECENTERC} > ui/img/detailed_fsm.dot

${BDIR}/ui:
	@mkdir -p ${BDIR}
	@ln -s ${PWD}/ui ./${BDIR}/ui

${BDIR}/img:
	@mkdir -p ${BDIR}
	@ln -s ${PWD}/ui/img ./${BDIR}/img

${BDIR}:
	@mkdir -p ${BDIR}

${BDIR}/varnish-book.pdf: ${common} ${bookutil} ${pdf_style}
	@echo Building PDFs for book...
	@${PICK} -v inc=${book} < ${mergedrst} | ${RST2PDF} -e=/usr/lib/pymodules/python2.7/rst2pdf/extensions/inkscape_r2p.py --section-header-depth=1 --break-level=3 -s ${pdf_style} -o ${BDIR}/varnish-book-${version}.pdf

${BDIR}/varnish_slides.pdf: ${common} ${bookutil} ${pdf_slide_style}
	@echo Building PDF slides for slides...
	@${PICK} -v inc=${slides} < ${mergedrst} | ./util/strip-class.gawk | ${RST2PDF} -e=/usr/lib/pymodules/python2.7/rst2pdf/extensions/inkscape_r2p.py --section-header-depth=1 --break-level=4 -s ${pdf_slide_style} -o $@

${BDIR}/varnish_slides-A4.pdf: ${common} ${bookutil} ui/pdf_slide-A4.style
	@echo Building PDF slides for slides-A4...
	@${PICK} -v inc=${slides-A4} < ${mergedrst} | ./util/strip-class.gawk | ${RST2PDF} -e=/usr/lib/pymodules/python2.7/rst2pdf/extensions/inkscape_r2p.py --section-header-depth=1 --break-level=3 -s ui/pdf_slide-A4.style -o $@

util/param.rst:
	varnishadm param.show | gawk 'NF {$$NF=""; printf ".. |def_"$$1"| replace::\t"; print substr($$0,index($$0,$$2))}' | column -ts "$$(printf '\t')"> util/param.rst

sourceupdate: util/param.rst flowchartupdate

clean:
	-rm -r build/

material/webdev/index.html: material/webdev/index.rst
	rst2html $< > $@

materialcheck:
	@$(MAKE) -C material/

check: vclcheck materialcheck
	@ret=0; for a in `ls -1 vcl/*.vcl material/webdev/*.php material/webdev/*.html | grep -v index`; do \
		grep -q $$a ${rstsrc} || { ret=1; echo "$$a is a file, but not included in the rst"; }; \
	done; \
	exit $$ret

.PHONY: all mrproper clean sourceupdate flowchartupdate util/param.rst vclcheck materialcheck
