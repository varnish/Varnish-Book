#!/bin/sh
# Author: Kristian Lyngstol <kristian@varnish-software.com>
#
# Generates RST for setting author, copyright, version.

echo ":Author: Tollef Fog Heen, Kristian Lyngstøl"
echo ":Copyright: Varnish Software AS 2010-2011, Redpill Linpro AS 2008-2009"

VER=`git tag -l --contains | sed s/version-// | head -n1`

# Not a tagged commit. Should probably trigger big red letters.
if [ -z $VER ]; then
	VER2="$(git tag -l | tail -n1)"
	VER="untagged draft version $(git log --format='%h' | head -n1), following ${VER2}"
fi

echo ":Version: $VER"
echo -n ":Date: "
git log --format="%ad" --date=short | head -n1

