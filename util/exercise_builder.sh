#!/bin/bash

title=$(util/pickchapter2.igawk -v 'include=RST TITLE STUB' exercises/${1}.test | egrep -v '^$' | tail -n1)
title_1=$(echo Exercise: ${title})
title_2=$(echo Solution: ${title})
underlines=$(echo ${title_1} | sed s/./-/g)

cat > "build/exercises/complete-${1}.rst" <<_EOF_
${title_1}
${underlines}
$(cat build/exercises/${1}.rst) 
$(cat build/exercises/handout-${1}.rst)

${title_2}
${underlines}

::

$(cat build/exercises/solution-${1}.rst)
$(cat build/exercises/solution-extra-${1}.rst)

_EOF_

