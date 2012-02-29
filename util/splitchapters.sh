#!/bin/bash

awk -v include="$*" -v inctop="0" -v dst=$2 '
BEGIN {
	chapter=""
	split(include,includea,",");
}
/^==+$/ {
	if (length(last) == length($0)) {
		chapter=last;
		chapterclean=chapter
		gsub("[^a-zA-Z0-9]","_",chapterclean)
		path = dst chapterclean ".rst"
		idx[i++] = chapterclean
		print ".. include:: util/param.rst" > path
		print "" >> path
	}
}
{
	if (chapter != "")
		print last >> path
}
{
	last = $0
}
END {
	if (chapter != "")
		print last >> path
	aidx = dst "/build/autoindex.rst"
	print ".. toctree::" > aidx
	print "\t:maxdepth: 1" >> aidx
	print "" >> aidx
	for (j=0; j<i; j++) {
		print "\t" idx[j] >> aidx
	}
}
' $1
