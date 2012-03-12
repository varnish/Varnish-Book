<?php
header("Cache-Control: max-age=0");
$cc = "";
if( isset($_POST['k']) and $_POST['k'] !== '' and
    isset($_POST['v']) and $_POST['v'] !== '') {
	$k=$_POST['k'];
	$v=$_POST['v'];
	$setc = "Set-Cookie: $k=$v";

	header("$setc");

}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head></head>
    <body>
        <h1>Set-Cookie Header:</h1>
        <?php
		print "<pre>$setc</pre>\n";
	?>
        <hr/>
        <h1>Links for testing</h1>
	<form action="/set-cookie.php" method="POST">
	Key: <input type="text" name="k">
	Value: <input type="text" name="v">
	<input type="submit">
	</form>
    </body>
</html>
