#!/bin/bash
# Generates RST for setting author, copyright, version.
# Author: Kristian Lyngstol <kristian@varnish-software.com>
#
# Copyright 2010-2012, Varnish Software AS 

v="0.0"

which git &> /dev/null || exit 1

v="$(git describe --always --dirty)"

cat <<__EOF__
:Authors: Tollef Fog Heen, Kristian Lyngstøl
:Copyright: Varnish Software AS 2010-2012, Redpill Linpro AS 2008-2009
:Version: ${v}
:Date: $(date +%Y-%m-%d)
__EOF__

