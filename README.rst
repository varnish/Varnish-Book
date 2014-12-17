Training material and related tools
===================================

This Github branch holds work in progress to update The Varnish Book for Varnish Plus.

This repository contains:

* Training material used for our Varnish training (the source for the
  slides and printed version)
* A snapshot of munin graphs for use by instructors.
* PHP example-code for testing Varnish
* Build system for said training material

This is the training material Varnish Software uses for professional
Varnish training courses. It is made available under a Creative Commons
CC-BY-NC-SA license (See the LICENSE file for details) as a book.

The build system produces different sets of PDFs. Varnish Software
currently offers two different two-day courses: `Varnish System
Administration`, which contains all chapters except the `HTTP` chapter and
`Content Composition`; and `Varnish for Web Developers` which contains all
chapters except `Tuning` and `Saving the Request`. The third set of slides,
labeled `Book`, contains all chapters. All the chapters are written with
this structure in mind.

Thanks
------

In addition to the authors, the following deserve special thanks (in no particular order):

- Rubén Romero
- Dag Haavi Finstad
- Sevan Janiyan
- Kacper Wysocki
- Magnus Hagander
- Martin Blix Grydeland
- Poul-Henning Kamp
- Everyone who has participated on the training courses

Index
-----

* build/ - Created on make, contains PDF output, html-output and necessary
  images
* Makefile
* material/ - PHP files, mainly used by the web-dev material
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
* varnish_book.rst - course itself
* vcl/ - VCL files used in the course. Not a copy. Included directly as-is,
  and verified by make check. (note: If 'backend' is missing, a generic
  backend will be added on the fly during make check).


Building the material
---------------------

The work in progress is being compiled on Ubuntu trusty 14.04 with the following tools:

- rst2pdf
- gawk (old awk is not sufficient)
- bash (I'm lazy)
- git (somewhat optional, I believe)
- make (possibly GNU make. Not tested)
- dot (for images)
- varnishd
- php5

All build-stuff is handled by make. The following is an incomplete list of targets:

``make check``
        Does syntax-checking on VCL and php-files. Ensures that they are
        used too.

``make all``
        Builds all PDFs (not sphinx)

``make dist``
        Builds tar-balls for use by instructurs, which contain PDFs,
        munin-snapshot, www-examples (material/), NEWS and a bit more.

``make clean``
        removes build/

``make sphinx``
        Builds sphinx into build/html/

``make sphinx-dist``
        Pushes the sphinx-build to the official server. Requires access to
        the right servers, naturally.

``make flowchartupdate``
        Updates the VCL flowcharts from varnish source-code, assuming the
        correct .c-file (e.g: varnish source-code) is located where
        Makefile checks. (read Makefile).

``make util/param.rst``
        Might require deleting the file first. Fetches varnish-parameters
        from varnishd (as found in your PATH) and updates the
        util/param.rst with the correct macros.

``make sourceupdate``
        Does both the util/param.rst-thing and flowchartupdate.

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

Legal
-----

This material is provided under a CC-BY-NC-SA license. The license is
available from:

http://creativecommons.org/licenses/by-nc-sa/3.0/

And a copy of the license is available in the LICENSE file.

Clarification: The Non-Commercial clause of the CC-BY-NC-SA license is
intentionally vague in the original license. Varnish Software does not
interpret reading of the material as commercial, regardless of context
(e.g: You can read the material at work, for the benefit of your self and
the company). The Non-Commercial clause is intended to block competition
with other commercial training offerings and to prohibit commercial
printing and selling of the book. If you have any doubt as to how this
should be interpreted, please contact training@varnish-software.com for
clarification before proceeding.
