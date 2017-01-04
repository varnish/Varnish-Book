<?php
header("Cache-Control: max-age=10");
$utc = new DateTimeZone("UTC");
$date = new DateTime("now", $utc);
$now = $date->format( DateTime::RFC2822 );
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head></head>
    <body>
        <h1>This article is cached for 10 seconds</h1>

        <h2>Cache timestamp: <?php echo $now; ?></h2>
        <a href="<?=$_SERVER['PHP_SELF']?>">Refresh this page</a>
    </body>
</html>
