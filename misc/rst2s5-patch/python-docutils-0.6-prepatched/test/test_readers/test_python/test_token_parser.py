#! /usr/bin/env python

# $Id: test_token_parser.py 4564 2006-05-21 20:44:42Z wiemann $
# Author: David Goodger <goodger@python.org>
# Copyright: This module has been placed in the public domain.

"""
Tests for docutils/readers/python/moduleparser.py.
"""

from __init__ import DocutilsTestSupport


def suite():
    s = DocutilsTestSupport.PythonModuleParserTestSuite()
    s.generateTests(totest, testmethod='test_token_parser_rhs')
    return s

totest = {}

totest['expressions'] = [
['''a = 1''', '''1'''],
['''a = b = 1''', '''1'''],
['''\
a = (
     1 + 2
     + 3
     )
''',
'''(1 + 2 + 3)'''],
['''\
a = """\\
line one
line two"""
''',
'''"""\\\nline one\nline two"""'''],
['''a = `1`''', '''`1`'''],
['''a = `1`+`2`''', '''`1` + `2`'''],
]


if __name__ == '__main__':
    import unittest
    unittest.main(defaultTest='suite')
