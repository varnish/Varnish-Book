#!/bin/bash

awk -v include="$*" -v inctop="1" '
BEGIN {
	chapter=""
	split(include,includea,",");
}
/^==+$/ {
	if (length(last) == length($0)) {
		 chapter=last;
	}
}
{
	for (a in includea) {
		if (includea[a] == chapter || (chapter != "" && includea[a] == "*")) {
			print last
			break
		}
	}
	if (inctop==1 && chapter == "")
		print last
}
{
	last = $0
}
' varnish_book.rst
