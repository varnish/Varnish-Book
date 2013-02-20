#!/usr/bin/gawk -f

# Removes a specific class, e.g "handout"

BEGIN {
	ignoreclass["handout"] = 1
}
{ 
	header = 0
}
/\.\. (class|container)::/ {
	if (ignoreclass[$3]) {
		ignore=1
		cignore=1
		if ($0 ~ "container")
			cignore=2
	} else {
#		cignore=0
	}
}

/^[-=.][-=.][-=.]+$/ {
#	print NR " chapter: " prev
	if (cignore == 1) {
		cignore = 2
	} else if (cignore == 2) {
		cignore = 0
		ignore =0
	}
	header=1
}

/:class: / {
	if (ignoreclass[$2]) {
		ignore=1
		cignore=5
	}
}
{
	if (ignore == 0) {
		if (header && prevreal != "")
			print ""

		print prev
		prevreal=prev
	}
	if (cignore==6) {
		cignore = 0
		ignore = 0
	}
		
	if (cignore==5)
		cignore=6
	prev=$0
}

END {
	if (ignore == 0)
		print prev
}

