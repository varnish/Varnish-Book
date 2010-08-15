#!/bin/sh
# Author: Kristian Lyngstol <kristian@varnish-software.com>
#
# Generates RST for setting author, copyright and version. The bigger part
# is the version. Soon: Date tag!

echo ":Author: Tollef Fog Heen, Kristian Lyngstøl"
echo ":Copyright: Varnish Software AS 2010, Redpill Linpro AS 2008-2009"
echo -n ":Version: "
# UGLY as hell. Awk fetches anything relevant until the first version- tag,
# the rest just strips pointless info.
TMP=`git log --format='%h %d' | awk '/version/ { if (versionfound != 1)  { versionfound=1 ; print $0; } }; /\(/ { if (versionfound != 1) print $0 } ' | sed 's/origin\/[a-Z]*//g' | sed 's/\(master\|tag:\)//g' | sed s/,//g | sed 's/ *)/)/'`
if [ $(echo "$TMP" | wc -l) -ne 1 ]; then
	echo -n "untagged draft version "
	echo $TMP
else
	echo $TMP | sed 's/.*(//' | sed 's/).*//' | sed 's/HEAD//' | sed 's/ version-//'
fi
echo -n ":Date: "
git log --format="%ad" --date=short | head -n1

