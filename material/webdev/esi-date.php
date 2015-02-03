<HTML>
<BODY>

<?php
header( 'Content-Type: text/plain' );

print( "This page is cached for 1 minute.\n" );
echo "Timestamp: \n"
. date("Y-m-d H:i:s");
print( "\n" );
?>

<esi:include src="/cgi-bin/date.cgi"/>

</BODY>
</HTML>
