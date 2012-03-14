<?php
header('Content-Type: text/html');
header('Cache-Control: max-age=30, s-maxage=3600');
$date = new DateTime();
$now = $date->format( DateTime::RFC2822 );
$setc = "";
if( isset($_POST['k']) and $_POST['k'] !== '' and
    isset($_POST['v']) and $_POST['v'] !== '') {
	$k=$_POST['k'];
	$v=$_POST['v'];
	$setc = "Set-Cookie: $k=$v";

	 header("$setc");
	 ?><meta http-equiv="refresh" content="1" />
	 <h1>Refreshing to set cookie <?php print $setc; ?></h1><?php
}
?>
<html><head><title>ESI top page</title></head><body><h1>ESI Test page</h1>
<p>This is content on the top-page of the ESI page. The top page is cached for 1 hour in Varnish, but only 30 seconds on the client.</p> <p>The time when the top-element was created:</p><h3>

<?php echo "$now"; ?>


<h1>Set a cookie:</h1><form action="/esi-top.php" method="POST">
Key: <input type="text" name="k">
Value: <input type="text" name="v">
<input type="submit"> </form>

</h3><p>The top page received the following Cookies:</p><ul>

<?php

foreach( $_COOKIE as $name => $value )
    print( "<li>${name} : ${value}</li>\n" );
?>


<table border="1"><tr><td><esi:include src="/esi-user.php" /></td></tr></table></body></html>
