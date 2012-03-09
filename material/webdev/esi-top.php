<?php
header('Content-Type: text/html');
header('Cache-Control: max-age=30, s-maxage=3600');
$date = new DateTime();
$now = $date->format( DateTime::RFC2822 );
?>
<html>
<head>
<title>ESI top page</title>
</head>
<body>
<h1>ESI Test page</h1>
<p>This is content on the top-page of the ESI page. The top page is cached
for 1 hour in Varnish, but only 30 seconds on the client.</p>
<p>The time when the top-element was created:</p>
<h3><?php echo "$now"; ?></h3>
<p>The top page received the following Cookies:</p>
<ul>
<?php

foreach( $_COOKIE as $name => $value )
    print( "<li>${name} : ${value}</li>\n" );
?>
</ul>
<p>The following is a table with "user-specific" content, included from
esi-user.php:</p>
<table><tr><td>
<esi:include src="/esi-user.php" />
</td></tr></table>
</body>
</html>

