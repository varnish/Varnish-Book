#!/usr/bin/env python

# $Id: rst2newlatex.py 4564 2006-05-21 20:44:42Z wiemann $
# Author: David Goodger <goodger@python.org>
# Copyright: This module has been placed in the public domain.

"""
A minimal front end to the Docutils Publisher, producing LaTeX using
the new LaTeX writer.
"""

try:
    import locale
    locale.setlocale(locale.LC_ALL, '')
except:
    pass

from docutils.core import publish_cmdline, default_description


description = ('Generates LaTeX documents from standalone reStructuredText '
               'sources. This writer is EXPERIMENTAL and should not be used '
               'in a production environment. ' + default_description)

publish_cmdline(writer_name='newlatex2e', description=description)
