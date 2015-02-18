RST2PDF=/usr/bin/rst2pdf
BDIR=build
CACHECENTERC=../varnish-cache-3.0/bin/varnishd/cache_center.c
PICK = "./util/pickchapter2.igawk"

# The following are chapter lists for the relevant versions of the PDFs.
# Please note that they need to be exact. No extra spaces, case sensitive
# etc.
# 
# If you want a new set, just make a new variable and that's the name of
# the pdfs you can now build.

book = "*"

# Selecting chapters in this way does not work.
# The script Varnish-Book/util/pickchapter2.igawk unsort them until the third chapter.
#"Abstract,Preface,Introduction,Getting Started,The Varnish Log,Tuning,VCL Basics,VCL Built-in Subroutines,Cache Invalidation,Mechanisms to Handle Backends in Problematic Situations,Content Composition,Appendix A: Resources,Appendix B: Varnish Programs,Appendix C: Extra Material,Appendix D: From Varnish 3 to Varnish 4"

test = "Tuning"
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
sysadmint = ${BDIR}/varnish-sysadmin.pdf ${BDIR}/varnish_slide-sysadmin.pdf
bookt= ${BDIR}/varnish-book.pdf ${BDIR}/varnish_slide-book.pdf
testt= ${BDIR}/varnish-test.pdf ${BDIR}/varnish_slide-test.pdf
materialpath = www_examples
rstsrc =varnish_book.rst
images = ui/img/cache_fetch.png ui/img/cache_req_fsm.png
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

targets = book sysadmin
#webdev book sysadmin

all: ${common} ${targets}

webdev: ${webdevt}

sysadmin: ${sysadmint}

book: ${bookt}

test: ${testt}

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
	util/splitchapters.igawk -v dst=src/ < ${mergedrst}
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

${mergedrst}: ${BDIR} ${rstsrc} ${BDIR}/version.rst
	util/parse.pl < ${rstsrc} > $@

${BDIR}/version.rst: util/version.sh ${mergedrst} .git/COMMIT_EDITMSG

	mkdir -p ${BDIR}
	./util/version.sh > ${BDIR}/version.rst

ui/img/%.png: ui/img/%.dot
	dot -Gsize=2000,3000 -Tpng < $< > $@

ui/img/%.svg: ui/img/%.dot
	dot -Tsvg < $< > $@

flowchartupdate:
	sed -n '/^DOT/s///p' ${CACHECENTERC} > ui/img/cache_req_fsm.dot

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
	@${PICK} -v inc=${$*} < ${mergedrst} | ${RST2PDF} -s ui/pdf.style -b2 -o $@

${BDIR}/varnish_slide-%.pdf: ${common} ui/pdf_slide.style
	@echo Building PDF slides for $*...
	@${PICK} -v inc=${$*} < ${mergedrst} | ./util/strip-class.gawk | ${RST2PDF} -s ui/pdf_slide.style -b2 -o $@

util/param.rst:
	( sleep 2; echo param.show ) | varnishd -n /tmp/meh -a localhost:2211 -d | gawk -v foo=0 '(foo == 2) && (/^[a-z]/) {  printf ".. |def_"$$1"| replace:: "; gsub($$1,""); print; } /^200 / { foo++;}' > util/param.rst

sourceupdate: util/param.rst flowchartupdate

clean:
	-rm -r build/

varnish_%-${version}.tar.bz2: check ${BDIR}/varnish-%.pdf ${BDIR}/varnish_slide-%.pdf ${BDIR}/${materialpath}.tar.bz2
	@echo Preparing $@ ...
	@target=${BDIR}/dist/varnish_$*-${version}/; \
	mkdir -p $${target};\
	mkdir -p $${target}/pdf/;\
	mkdir -p $${target}/img/;\
	cp -r ${BDIR}/varnish-$*.pdf $$target/pdf/varnish_$*-v${version}.pdf;\
	cp -r ${BDIR}/varnish_slide-$*.pdf $$target/pdf/varnish_slide_$*-v${version}.pdf;\
	cp -r munin/ $${target};\
	cp ui/img/cache_fetch.png ui/img/cache_req_fsm.png $${target}/img/; \
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
