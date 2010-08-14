#!/bin/sh
# Author: Kristian Lyngstol <kristian@varnish-software.com>
#
# Generates RST for setting author, copyright and version. The bigger part
# is the version. Soon: Date tag!

echo ":Author: Tollef Fog Heen, Kristian Lyngstøl"
echo ":Copyright: Varnish Software AS 2010, Redpill Linpro AS 2008-2009"
echo -n ":Version: "
TMP=`git log --format='%h %d' | grep HEAD | sed 's/origin\/[a-Z]*//g' | sed s/master// | sed s/,//g | sed 's/ *)/)/'| head -n2`
if [ $(echo "$TMP" | wc -l) -ne 1 ]; then
	echo -n "untagged/unreleased draft version "
fi
echo $TMP
