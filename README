Training material and related tools
===================================

This repository contains:

* The training material used for our Varnish training (the source for the
  slides and printed version)
* A snapshot of vg.no/'s munin graphs for use by instructors.
* Build system for said training material
* Scripts to populate usb sticks. (soon)

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


Updating the training material
------------------------------

The first thing you should do, is grab a copy of the various RST
documentation out there. Sadly enough, you will need it for some of the
finer points.

The second thing you should do, is read NEWS, and make sure you always
add significant content changes there, so the instructor(s) can keep track
of what changes between version-1.5 and version-1.7 without reading commit
logs which also contain edits to Makefile and whatnot.

There are TWO tools at work here:

- rst2pdf
- rst2s5

rst2pdf generates the PDF, and needs a bit of help to get page numbering
properly formated, that's where the oddeven stuff at the top comes in.
The problem with that, is that it is not proper rst, so rst2s5 will
complain about. That is why rst2s5 has been told to IGNORE errors. This
means that the only errors you get are from rst2pdf. Live with it (for
now?).

rst2s5 creates presentations in the s5-language/format/thingamajing. It is
not originally intended for documents of the size that we need, so by
default it will break for a new slide only at top-level headings. That is
fairly useless when we have this many slides, so a slight modification has
been made. I (Kristian) have yet to publish this anywhere, but it's fairly
trivial. I'll add the patch or a complete version here soon enough.

To add handout-only content, there are two methods you can use. Either use
a container with the handout class:

   .. container:: handout

      All of this is now handout-only material.

      This too.

Or you can use a .. role:: handout followed by a proper chapter, typically
a third-level chapter:

   .. role:: handout

   Handoutonly chapter
   ...................

   This chapter is now handout-only, and everything until a new chapter is
   defined is handout-only. Convenient for adding lengthy sections that are
   either not suitable for everyone, or covered by examples and talk on a
   bigger slide (ie: architecture).

I have tried to use .. tip::, .. warning:: and .. note::, and no further
"boxes".

To change the looks of the slides, edit ui/vs/pretty.css (possibly other
css files, but unlikely). To change the look of the PDF, change
ui/pdf.style.

Instructor comments are simple rst comments: .. on a line by itself (NO
trailing white-space), followed immediately by the comment. They are
currently a bit of a hack in the Makefile, so avoid multi-line comments or
other rst-trickery - it wont work.
