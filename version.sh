#!/bin/sh
# Author: Kristian Lyngstol <kristian@varnish-software.com>
#
# Generates RST for setting author, copyright and version. The bigger part
# is the version. Soon: Date tag!

echo ":Author: Tollef Fog Heen, Kristian Lyngstøl"
echo ":Copyright: Varnish Software AS 2010, Redpill Linpro AS 2008-2009"

VER=`git tag -l --contains | sed s/version-//`
if [ -z $VER ]; then
	VER="untagged draft version $(git log --format '%h' | head -n1)"
fi

echo ":Version: $VER"
echo -n ":Date: "
git log --format="%ad" --date=short | head -n1

