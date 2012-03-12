<?php
$cc = "";
if( isset($_GET['k']) and $_GET['k'] !== '' and
    isset($_GET['v']) and $_GET['v'] !== '') {
	$k=$_GET['k'];
	$v=$_GET['v'];
	$cc = "Cache-Control: $k=$v";

	header("$cc");

}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head></head>
    <body>
        <h1>Cache-Control Header:</h1>
        <?php
		print "<pre>$cc</pre>\n";
	?>
        <hr/>
        <h1>Links for testing</h1>
	<form action="/test.php" method="GET">
	Key: <input type="text" name="k">
	Value: <input type="text" name="v">
	<input type="submit">
	</form>
    </body>
</html>
