<?php
header('Content-Type: text/html');
header('Cache-Control: max-age=30, s-maxage=20');
header('Vary: Cookie');
$date = new DateTime();
$now = $date->format( DateTime::RFC2822 );
?>
<p>This is content on the user-specific ESI-include. This part of the page
is not cached in Varnish. We can not affect the client-cache of this
sub-page, since that is determined by the cache-control headers on the
top-element.</p>
<p>The time when the user-specific-element was created:</p><h3>

<?php echo "$now"; ?>

</h3><p>The user-specific page received the following Cookies:</p><ul>

<?php

foreach( $_COOKIE as $name => $value )
    print( "<li>${name} : ${value}</li>\n" );
?>

</ul>
