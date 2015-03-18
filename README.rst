Training material and related tools
===================================

This Github branch holds work in progress to update The Varnish Book for Varnish Plus.

This repository contains:

* Training material used for Varnish Plus training
* Source for the slides and book version
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
- Per Buer
- Sevan Janiyan
- Kacper Wysocki
- Magnus Hagander
- Martin Blix Grydeland
- Poul-Henning Kamp
- Reza Naghibi
- Federico G. Schwindt
- Everyone who has participated on the training courses

Index
-----

* build/ - Created on make, contains PDF output, html-output and necessary images
* Makefile
* material/ - PHP files, mainly used by the web-dev material
* misc/ - Contains strange stuff. Including the old course (Linpro-source) and a patch for rst2s5 needed (and a pre-patched version).
* munin/ - Anonymized munin graphs for instructors
* NEWS - List of changes instructors should be be aware of from version to version.
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

Install the following packages with their dependencies.

- rst2pdf
- gawk
- git
- make
- graphviz
- php5
- python3-sphinx
- python-docutils

You also need the "Open Source" font type.
To check whether you have it, type ``fc-match "Open Sans"`` in the terminal.
The command should output ``OpenSans-Regular.ttf: "Open Sans" "Regular"``.
Otherwise, download it and install it.

Download the source code of this book::

  git clone https://github.com/varnish/Varnish-Book.git

Get into the right branch::

  cd Varnish-Book
  git checkout Varnish-Book-v4

Compile the book::

  make book

All build-stuff is handled by make.
The following is an incomplete list of targets:

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

Read NEWS, and make sure you always add significnat content changes in this file, so the instructor(s) can keep track of changes without reading commit logs.

Try to use only `tip`, `warning` and `note` boxes.

To change the layout, change ``ui/pdf.style`` or ``ui/pdf_slide.style``.

Legal
-----

This material is provided under a CC-BY-NC-SA license.
The license is available from:

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
