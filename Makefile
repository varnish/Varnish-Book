
RST2PDF=/usr/local/bin/rst2pdf

all: kurs.html kurs.pdf vcl.png

kurs.html: kurs.rst Makefile
	/usr/bin/rst2s5 kurs.rst -r 5 --current-slide --theme-url=ui/vs/ kurs.html

kurs.pdf: kurs.rst Makefile manual.style
	 ${RST2PDF} -s ./manual.style -b2 kurs.rst

%.png: %.dot Makefile
	dot -Tpng < $< > $@

