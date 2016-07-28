#!/bin/bash
# Generates RST for setting author, copyright, version.
# Author: Kristian Lyngstol <kristian@varnish-software.com>
#
# Copyright 2010-2013, Varnish Software AS

v="0.0"
if which varnishstat >/dev/null; then
  varnishversion=$(varnishstat -V 2>&1 | head -n1 | sed 's/.*(//; s/ revision.*//; s/varnish-//')
  varnishtested="Tested for Varnish ${varnishversion}"
else
  varnishtested="Not tested on build machine"
fi
which git &> /dev/null || exit 1

v="$(git describe --always --dirty)"

cat <<__EOF__
:Authors: Francisco Velázquez (\`Varnish Software\`_),
          Kristian Lyngstøl,
          Tollef Fog Heen,
	  Jérôme Renard
:Copyright: Varnish Software AS 2010-2015, Redpill Linpro AS 2008-2009
:Versions: Documentation version ${v} / ${varnishtested}
:Date: $(date +%Y-%m-%d)
:License: The material is available under a CC-BY-NC-SA license. See
	  http://creativecommons.org/licenses/by-nc-sa/3.0/ for the full
	  license. For questions regarding what we mean by non-commercial,
	  please contact training@varnish-software.com.
:Contact: For any questions regarding this training material, please
          contact training@varnish-software.com.
:Web:     http://www.varnish-software.com/book/
:Source:  http://github.com/varnish/Varnish-Book/

.. _Varnish Software: http://www.varnish-software.com/

__EOF__
