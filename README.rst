Training material and related tools
===================================

This repository contains:

* The training material used for our Varnish training (the source for the
  slides and printed version)
* A snapshot of munin graphs for use by instructors.
* Build system for said training material

This material serves multiple purposes.

First of all, this is the training material Varnish Software uses for
professional Varnish training courses. That is the original motivation for
writing this material.

Secondly, it is now (soon?) used as a public tutorial to complement the
reference documentation.

For training, we hold different courses, hence the existence of different
PDFs. We also build a "slide" PDF for this purpose, which is why the layout
of the individual chapters is the way it is.

Index
-----

* build/ - Created on make, contains PDF output, html-output and necessary
  images
* Makefile
* misc/ - Contains strange stuff. Including the old course (Linpro-source)
  and a patch for rst2s5 needed (and a pre-patched version).
* munin/ - Anonymized munin graphs for instructors
* NEWS - List of changes _instructors_ should be be aware of from version
  to version.
* README - This file
* TODO
* ui/ - Images, style-definitions for PDFs and CSS for the slides.
* util/ - Headers for the rst, tool to make version.rst, strip-class to
  remove an rst-class (for generating slides as PDF instead of s5).
* varnish_sysadmin.rst - course itself
* vcl/ - VCL files used in the course. Not a copy. Included directly as-is,
  and verified by make check. (note: If 'backend' is missing, a generic
  backend will be added on the fly during make check).


Building the material
---------------------

The following tools are needed:

- rst2pdf
- gawk (old awk is not sufficient)
- bash (I'm lazy)
- git (somewhat optional, I believe)
- make (possibly GNU make. Not tested)
- dot (for images)

Updating the training material
------------------------------

The first thing you should do, is grab a copy of the various RST
documentation out there. Sadly enough, you will need it for some of the
finer points.

The second thing you should do, is read NEWS, and make sure you always
add significant content changes there, so the instructor(s) can keep track
of what changes between version-1.5 and version-1.7 without reading commit
logs which also contain edits to Makefile and whatnot.

- rst2pdf

rst2pdf generates the PDF, and needs a bit of help to get page numbering
properly formated, that's where the oddeven stuff at the top comes in.
The problem with that, is that it is not proper rst, so other tools will
complain about it.

I have tried to use `tip`, `warning` and `note`, and no further
"boxes".

To change the look of the PDF, change ui/pdf.style.
