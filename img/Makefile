
objects = vcl.png

all: $(objects)

%.png: %.dot Makefile
	dot -Tpng < $< > $@

clean:
	-rm $(objects)
