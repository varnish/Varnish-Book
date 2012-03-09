<?php

        break;

        case "s-maxage" :
	    $cachecontrol['s-maxage'] = $_GET['v'];
        break;
    }

}

$cc = "Cache-Control: $_GET['k']=$_GET['v']");
header("$cc");
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
