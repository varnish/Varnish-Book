#!/bin/bash
# Generates RST for setting author, copyright, version.
# Author: Kristian Lyngstol <kristian@varnish-software.com>
#
# Copyright 2010,2011, Varnish Software AS 
# Copyright 2008, Aron Griffis <agriffis@n01se.net>
# Copyright 2008, Oracle
#
# Released under the GNU GPLv2
#
#
# Note: The copyright for this script is probably irrelevant due to its
# size, but the btrfs-snippet I (Kristian) finally ended up borrowing is
# GPL2, thus I figure this script is also GPL2 if it ever matters.
#
# Note 2: The copyright that is echoed relates to the course material and
# not the script.
#
# Note 3: I now have more comments than code here. Yai....

echo ":Author: Tollef Fog Heen, Kristian Lyngstøl"
echo ":Copyright: Varnish Software AS 2010-2011, Redpill Linpro AS 2008-2009"
v="0.0"

# Borrowed from btrfs version.sh (GPL2)
which git &> /dev/null
if [ $? == 0 -a -d .git ]; then
    if head=`git rev-parse --verify HEAD 2>/dev/null`; then
        if tag=`git describe --tags 2>/dev/null`; then
            v="$tag"
        fi

        # Are there uncommitted changes?
        git update-index --refresh --unmerged > /dev/null
        if git diff-index --name-only HEAD >/dev/null; then
            v="$v"-dirty
        fi
    fi
fi

echo ":Version: ${v}"
echo ":Date: " $(date +%Y-%m-%d)
