#!/bin/bash
# Generates RST for setting author, copyright, version.
# Author: Kristian Lyngstol <kristian@varnish-software.com>
#
# Copyright 2010-2012, Varnish Software AS 

v="0.0"

varnishversion=$(varnishd -V 2>&1 | head -n1 | sed 's/.*(//; s/ revision.*//; s/varnish-//')
which git &> /dev/null || exit 1

v="$(git describe --always --dirty)"

cat <<__EOF__
:Authors: Tollef Fog Heen, Kristian Lyngstøl, Jérôme Renard
:Copyright: Varnish Software AS 2010-2012, Redpill Linpro AS 2008-2009
:Versions: Documentation ${v} / Tested for Varnish ${varnishversion}
:Date: $(date +%Y-%m-%d)
:License: The material is available under a CC-BY-SA-NC license. See
	  http://creativecommons.org/licenses/by-nc-sa/3.0/ for the full
	  license. For questions regarding what we mean by non-commercial,
	  please contact training@varnish-software.com.
:Contact: For any questions regarding this training material, please
          contact training@varnish-software.com.


__EOF__

