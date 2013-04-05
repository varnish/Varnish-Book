<?php
header( "Cache-Control: public, must-revalidate, max-age=3600, s-maxage=3600"  );

$date = new DateTime();
$now = $date->format( DateTime::RFC2822 );
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head></head>
    <body>
        <h1>This is an article, cached for 1 hour</h1>

        <h2>Now is <?php echo $now; ?></h2>
        <a href="<?=$_SERVER['PHP_SELF']?>">Refresh this page</a>
    </body>
</html>
