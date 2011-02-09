#!/usr/bin/env python3

# $Id $
# Author: Georg Brandl <georg@python.org>
# Copyright: This module has been placed in the public domain.

"""
Transparently convert the test suite to Python 3 compatible code,
copy it to build/lib, where a converted docutils package is
expected to already be, and run the test suite.
"""

import sys, os

if sys.version_info >= (3,):
    from distutils.util import copydir_run_2to3
    print ('Copying and converting test suite for Python 3 '
           'to build/lib/test...')
    testroot = os.path.dirname(__file__)
    newroot = os.path.join(testroot, '..', 'build/lib/test')
    copydir_run_2to3(testroot, newroot)#, 'prune test_readers/test_python')
    sys.path[0] = newroot

# let the "if __name__ == '__main__'" block execute
exec(open('build/lib/test/alltests.py').read())
