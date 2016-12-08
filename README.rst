Training material and related tools
===================================

This repository contains:

* Training material used for Varnish Plus training
* Source for the slides and book version
* A snapshot of munin graphs for use by instructors.
* PHP example-code for testing Varnish
* Build system for said training material

This is the training material Varnish Software uses for professional
Varnish training courses. It is made available under a Creative Commons
CC-BY-NC-SA license (see the LICENSE file for details) as a book.

The build system produces the book in PDF and HTML formats.
The PDF format includes two editions, one as the book for trainees, and the other as slides for the trainer.
You can download this book in PDF format from https://www.varnish-software.com/download-varnish-book.

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
* src/ - Resource files for sphinx to export the book in HTML version.
  This folder contains a Makefile to build the book in different formats.
  Enter to the directory and type ``make`` to see the building targets.

Building the material
---------------------

Install the following packages with their dependencies.

- ``rst2pdf``
- ``gawk``
- ``git``
- ``make``
- ``graphviz``
- ``php5``
- ``sphinx`` 1.3 or later
- ``python-docutils``
- ``inkscape``
- ``Open Sans`` font type

You also need the "Open Source" font type.
To check whether you have it, type ``fc-match "Open Sans"`` in the terminal.
The command should output ``OpenSans-Regular.ttf: "Open Sans" "Regular"``.
Otherwise, do the following::

  $ wget http://www.fontsquirrel.com/fonts/download/open-sans
  $ sudo unzip open-sans -d /usr/local/share/fonts/truetype/
  $ rm open-sans
  $ fc-cache
  $ fc-match "Open Sans"

Download the source code of this book::

  git clone https://github.com/varnish/Varnish-Book.git

Compile the book::

  make book

All build-stuff is handled by make.
The following is an incomplete list of targets:

``make book``
        Builds book in PDF format

``make sphinx``
        Builds book in HTML and ePub format

``make slides``
        Builds slides in PDF format.
        This slides are to be used in a training course.

``make clean``
        removes build/

``make util/param.rst``
        Updates the default values of your Varnish installation.
	    These values are the ones to be used in your book building.

``make sourceupdate``
        Calls ``util/param.rst`` rule and will call other rules to update the sources of the book.

..
   ``make check``
	   Does syntax-checking on VCL and php-files. Ensures that they are
	   used too.

   ``make all``
	   Builds all PDFs (not sphinx)


   ``make dist``
	   Builds tar-balls for use by instructors, which contain PDFs,
	   munin-snapshot, www-examples (material/), NEWS and a bit more.

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

Updating the training material
------------------------------

Read NEWS, and make sure you always add significant content changes in this file, so the instructor(s) can keep track of changes without reading commit logs.

Try to use only `tip`, `warning` and `note` boxes.

To change the layout, change ``ui/pdf.style`` or ``ui/pdf_slide.style``.

The syntax for indirect hyperlink targets (double underscores ``__``) is not the same for rst as for sphinx.
Thefore, for simplicity, avoid them.
More than two refereces per sentence is not supported by ``rst2sphinxparser.igawk``.

Figures and tables must have a counter right before their directive.
The counter must be as the following example::

  .. figure 1

or::

  .. table 1

Use ``git-tag`` every time that the book is printed and distributed.

Known issues
------------

This subsection includes known **issues for building the book in different formats**.

Building with `sphinx`
......................

- List of figures and list of tables do not work when the figure or table caption includes a reference.
  This is a limitation to create the PDF with sphinx.
- Fonts are not resized in notes or other cases such ``:class: tinycode``.

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
