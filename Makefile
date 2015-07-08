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

test = "The Varnish Log"
#test = "Varnish request flow for the client worker thread"
# TOFIX: the sysadmin target is not compiling as expected.
# sysadmin = "Abstract,Preface,Introduction,Getting\ started,The\ Varnish\ Log,Tuning,VCL\ Basics,VCL\ built-in\ subroutines,Cache\ invalidation,Appendix\ A:\ Vanish\ Programs"

#webdev = "Introduction,Getting started,HTTP,VCL Basics,VCL functions,Cache invalidation,Content Composition,Finishing words"

exercises = $(basename $(notdir $(wildcard exercises/*test)))
exercises_solutions = $(addprefix ${BDIR}/exercises/solution-,$(addsuffix .rst,${exercises}))
exercises_handouts = $(addprefix ${BDIR}/exercises/handout-,$(addsuffix .rst,${exercises}))
exercises_task = $(addprefix ${BDIR}/exercises/,$(addsuffix .rst,${exercises}))
exercises_vtc = $(addprefix ${BDIR}/exercises/,$(addsuffix .vtc,${exercises}))
exercises_complete = $(addprefix ${BDIR}/exercises/complete-,$(addsuffix .rst,${exercises}))
exercise_stuff = ${exercises_solutions} ${exercises_task} ${excercises_vtc} ${excercises_handouts}

#webdevt = ${BDIR}/varnish-webdev.pdf ${BDIR}/varnish_slide-webdev.pdf
#sysadmint = ${BDIR}/varnish-sysadmin.pdf ${BDIR}/varnish_slide-sysadmin.pdf
bookt= ${BDIR}/varnish-book.pdf
slidest= ${BDIR}/varnish_slides.pdf
slides-A4t=${BDIR}/varnish_slides-A4.pdf
testt=${BDIR}/varnish-test.pdf ${BDIR}/varnish_slide-test.pdf
materialpath = www_examples
rstsrc =varnish_book.rst
images = ui/img/simplified_fsm.png ui/img/detailed_fsm.png ui/img/detailed_fsm_backend.png
mergedrst = ${BDIR}/merged_book.rst

common = ${mergedrst} \
	 ${rstsrc} \
	 ${BDIR}/version.rst \
	 ${images} \
	 Makefile \
	 vcl/*.vcl \
	 util/control.rst \
	 util/frontpage.rst \
	 util/printheaders.rst \
	 ${exercises_complete} \
	 ${exercises_stuff} \
	 material/webdev/*

version = $(subst version-,,$(shell git describe --always --dirty))
versionshort = $(subst version-,,$(shell git describe --always --abbrev=0))

targets = book slides
#webdev book sysadmin

all: ${common} ${targets}

webdev: ${webdevt}

# sysadmin: ${sysadmint}

book: ${bookt}

slides: ${slidest}

slides-A4: ${slides-A4t}

test: ${testt}

src/conf.py: src/conf.py.in ${BDIR}/version.rst
	sed 's/@@VERSION@@/${version}/g; s/@@SHORTVERSION@@/${versionshort}/g;' < $< > $@

sphinx: ${common} src/conf.py
	for a in ui util/* vcl material build/version.rst ; do \
		if [ ! -e src/$$a ]; then \
			ln -s ${PWD}/$$a src/$$a ;\
		fi; \
	done;

#This loop should be improved! This clears out frontpage.rst and printheaders.rst and creates wrong pdf later.
	for a in src/util/frontpage.rst src/util/printheaders.rst; do \
		rm $$a; \
		touch $$a; \
	done

#Splits chapters into individual files, and creates the index page for sphinx.
	mkdir -p src/build/chapters
	ln -sf ${PWD}/ui build/chapters/
	ln -sf ${PWD}/tables build/chapters/
	util/rst2sphinxparser.igawk -v dst=${PWD}/src/ < ${mergedrst}

#Removes '.. class:: handout' from src/*.rst
	sed -i 's/\.\. class:: handout//' src/*.rst

	sphinx-build -b html -d build/doctrees   src/ build/html

sphinx-dist: sphinx book
	rsync -av build/html/ angela:/srv/www.varnish-software.com/static/book/
	ssh angela find /srv/www.varnish-software.com/static/book/ -exec chmod g+w "{}" "\;"
	scp ${BDIR}/varnish-book.pdf angela:/srv/www.varnish-software.com/static/pdfs/varnish-book-${version}.pdf
	scp ${BDIR}/varnish-book.pdf angela:/srv/www.varnish-software.com/static/pdfs/varnish-book.pdf
	ssh angela find /srv/www.varnish-software.com/static/pdfs/ -exec chmod g+w "{}" "\;"

mrproper: clean all

.git/COMMIT_EDITMSG:
	touch .git/COMMIT_EDITMSG

${mergedrst}: ${BDIR} ${rstsrc} ${BDIR}/version.rst util/frontpage.rst
	util/parse.pl < ${rstsrc} > $@

${BDIR}/version.rst: util/version.sh ${mergedrst} .git/COMMIT_EDITMSG

	mkdir -p ${BDIR}
	./util/version.sh > ${BDIR}/version.rst

ui/img/%.png: ui/img/%.dot
	dot -Gsize=2000,3000 -Tpng < $< > $@

ui/img/%.svg: ui/img/%.dot
	dot -Tsvg < $< > $@

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

${BDIR}/varnish-book.pdf: ${common} ${pdf_style}
	@echo Building PDFs for book...
	@${PICK} -v inc=${book} < ${mergedrst} | ${RST2PDF} --section-header-depth=1 --break-level=3 -s ${pdf_style} -o $@

${BDIR}/varnish_slides.pdf: ${common} ${pdf_slide_style}
	@echo Building PDF slidesfor slides...
	@${PICK} -v inc=${slides} < ${mergedrst} | ./util/strip-class.gawk | ${RST2PDF} --section-header-depth=1 --break-level=3 -s ${pdf_slide_style} -o $@

${BDIR}/varnish_slides-A4.pdf: ${common} ui/pdf_slide-A4.style
	@echo Building PDF slides for slides-A4...
	@${PICK} -v inc=${slides-A4} < ${mergedrst} | ./util/strip-class.gawk | ${RST2PDF} --section-header-depth=1 --break-level=3 -s ui/pdf_slide-A4.style -o $@

util/param.rst:
	( sleep 2; echo param.show ) | varnishd -n /tmp/meh -a localhost:2211 -d | gawk -v foo=0 '(foo == 2) && (/^[a-z]/) {  printf ".. |def_"$$1"| replace:: "; gsub($$1,""); print; } /^200 / { foo++;}' > util/param.rst

sourceupdate: util/param.rst flowchartupdate

clean:
	-rm -r build/

varnish_%-${version}.tar.bz2: check ${BDIR}/varnish-%.pdf ${BDIR}/varnish_slides-%.pdf ${BDIR}/${materialpath}.tar.bz2
	@echo Preparing $@ ...
	@target=${BDIR}/dist/varnish_$*-${version}/; \
	mkdir -p $${target};\
	mkdir -p $${target}/pdf/;\
	mkdir -p $${target}/img/;\
	cp -r ${BDIR}/varnish-$*.pdf $$target/pdf/varnish_$*-v${version}.pdf;\
	cp -r ${BDIR}/varnish_slides-$*.pdf $$target/pdf/varnish_slides_$*-v${version}.pdf;\
	cp -r munin/ $${target};\
	cp ${} $${target}/img/; \
	cp -r ${BDIR}/${materialpath}.tar.bz2 $$target; \
	cp NEWS ${mergedrst} README.rst LICENSE $$target;\
	tar -hC ${BDIR}/dist/ -cjf $@ varnish_$*-${version}/

dist: $(addprefix varnish_,$(addsuffix -${version}.tar.bz2,${targets}))

material/webdev/index.html: material/webdev/index.rst
	rst2html $< > $@

${BDIR}/${materialpath}.tar.bz2: material/webdev/index.html ${BDIR} material/ material/webdev/*
	-rm -r ${BDIR}/${materialpath}
	mkdir -p ${BDIR}/${materialpath}
	cp -a material/webdev/* ${BDIR}/${materialpath}
	tar -hC ${BDIR}/ -cjf $@ ${materialpath}

${BDIR}/exercises: ${BDIR}
	mkdir -p ${BDIR}/exercises

${BDIR}/exercises/%.vtc: exercises/%.test Makefile ${BDIR}/exercises
	util/pickchapter2.igawk -v "inc=VARNISHTEST" $<  | egrep -v '^[^[:blank:]]' > $@

${BDIR}/exercises/desc-%.rst: exercises/%.test ${BDIR}/exercises
	util/pickchapter2.igawk -v "inc=RST DESCRIPTION" $< | egrep -v '(RST DESCRIPTION|===============)' > $@

${BDIR}/exercises/solution-%.rst: ${BDIR}/exercises/%.vtc ${BDIR}/exercises
	awk '/} -start/ { p=0 }; p == 1; /varnish v1 -vcl\+backend {/ { p=1 };' $< > $@

${BDIR}/exercises/handout-%.rst: exercises/%.test ${BDIR}/exercises
	util/pickchapter2.igawk -v "inc=RST HANDOUT" $< | egrep -v '(RST HANDOUT|==========)' > $@

${BDIR}/exercises/solution-extra-%.rst: exercises/%.test ${BDIR}/exercises
	util/pickchapter2.igawk -v "inc=SOLUTION EXTRA" $< | egrep -v '^(SOLUTION EXTRA|==============)$$' > $@

${BDIR}/exercises/complete-%.rst: ${BDIR}/exercises/solution-%.rst ${BDIR}/exercises/desc-%.rst ${BDIR}/exercises/handout-%.rst ${BDIR}/exercises/solution-extra-%.rst util/exercise_builder.sh
	util/exercise_builder.sh "$*"

vclcheck: ${exercises_vtc}
	@$(MAKE) -C vcl/
	varnishtest -j3 ${exercises_vtc}

materialcheck:
	@$(MAKE) -C material/

check: vclcheck materialcheck
	@ret=0; for a in `ls -1 vcl/*.vcl material/webdev/*.php material/webdev/*.html | grep -v index`; do \
		grep -q $$a ${rstsrc} || { ret=1; echo "$$a is a file, but not included in the rst"; }; \
	done; \
	exit $$ret

.PHONY: all mrproper clean sourceupdate flowchartupdate util/param.rst vclcheck materialcheck
