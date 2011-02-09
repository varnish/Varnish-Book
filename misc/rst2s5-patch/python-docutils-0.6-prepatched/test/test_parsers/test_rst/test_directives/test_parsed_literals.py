#! /usr/bin/env python

# $Id: test_parsed_literals.py 5174 2007-05-31 00:01:52Z wiemann $
# Author: Lea Wiemann <LeWiemann@gmail.com>
# Copyright: This module has been placed in the public domain.

"""
Tests for the body.py 'parsed-literal' directive.
"""

from __init__ import DocutilsTestSupport

def suite():
    s = DocutilsTestSupport.ParserTestSuite()
    s.generateTests(totest)
    return s

totest = {}

totest['parsed_literals'] = [
["""\
.. parsed-literal::

   This is a parsed literal block.
   It may contain *inline markup
   spanning lines.*
""",
"""\
<document source="test data">
    <literal_block xml:space="preserve">
        This is a parsed literal block.
        It may contain \n\
        <emphasis>
            inline markup
            spanning lines.
"""],
["""\
.. parsed-literal:: argument
""",
"""\
<document source="test data">
    <system_message level="3" line="1" source="test data" type="ERROR">
        <paragraph>
            Error in "parsed-literal" directive:
            no arguments permitted; blank line required before content block.
        <literal_block xml:space="preserve">
            .. parsed-literal:: argument
"""],
["""\
.. parsed-literal::
""",
"""\
<document source="test data">
    <system_message level="3" line="1" source="test data" type="ERROR">
        <paragraph>
            Content block expected for the "parsed-literal" directive; none found.
        <literal_block xml:space="preserve">
            .. parsed-literal::
"""],
]


if __name__ == '__main__':
    import unittest
    unittest.main(defaultTest='suite')
