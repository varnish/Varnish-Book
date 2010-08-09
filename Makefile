
RST2PDF=/usr/local/bin/rst2pdf

all: varnish_sysadmin.html varnish_sysadmin.pdf vcl.png

varnish_sysadmin.html: varnish_sysadmin.rst Makefile
	/usr/bin/rst2s5 varnish_sysadmin.rst -r 5 --current-slide --theme-url=ui/vs/ varnish_sysadmin.html

varnish_sysadmin.pdf: varnish_sysadmin.rst Makefile manual.style
	 ${RST2PDF} -s ./manual.style -b2 varnish_sysadmin.rst

%.png: %.dot Makefile
	dot -Tpng < $< > $@

