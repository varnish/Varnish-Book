<?php
header( 'Content-Type: text/plain' );

print( "The following cookies have been received from the server\n" );

foreach( $_COOKIE as $name => $value )
    print( "- ${name} : ${value}\n" );
?>