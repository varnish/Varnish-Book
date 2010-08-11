
objects = vcl.png

all: $(objects)

%.png: %.dot Makefile
	dot -Tpng < $< > $@

%.svg: %.dot Makefile
	dot -Tsvg < $< > $@

clean:
	-rm $(objects)
