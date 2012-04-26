#!/bin/bash

title=$(util/pickchapter2.igawk -v 'include=RST TITLE STUB' exercises/${1}.test | egrep -v '^$' | tail -n1)
title_1=$(echo Exercise: ${title})
title_2=$(echo Solution: ${title})
underlines=$(echo ${title_1} | sed s/./-/g)

cat > "exercises/complete-${1}.rst" <<_EOF_
${title_1}
${underlines}
$(cat exercises/${1}.rst) 
$(cat exercises/handout-${1}.rst)

${title_2}
${underlines}

::

$(cat exercises/solution-${1}.rst)
$(cat exercises/solution-extra-${1}.rst)

_EOF_

