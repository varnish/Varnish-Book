RST2PDF=/usr/bin/rst2pdf
BDIR=build
PICK = "./util/pickchapter2.igawk"

version = $(subst version-,,$(shell git describe --always --dirty))
versionshort = $(subst version-,,$(shell git describe --always --abbrev=0))

pdf_slide_style = ui/pdf_slide.style
pdf_style = ui/pdf.style

book = "*"
slides = "*"
slides-A4 = "*"

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
	 material/webdev/*

bookutil =  util/frontpage.rst \
	    util/printheaders.rst

targets = book slides sphinx

all: ${common} ${bookutil} ${targets}

webdev: ${webdevt}

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
	-rm ${images}

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
