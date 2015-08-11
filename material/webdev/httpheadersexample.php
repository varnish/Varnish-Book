<?php
date_default_timezone_set('UTC');
define( 'LAST_MODIFIED_STRING', 'Sat, 09 Sep 2000 22:00:00 GMT' );

// expires_date : 10s after page generation
$expires_date = new DateTime();
$expires_date->add(new DateInterval('PT10S'));

$headers = array(
    'Date' => date( 'D, d M Y H:i:s', time() ),
);

if( isset( $_GET['h'] ) and $_GET['h'] !== '' )
{
    switch( $_GET['h'] )
    {
        case "expires" :
            $headers['Expires'] = toUTCDate($expires_date);
        break;

        case "cache-control":
            $headers['Cache-Control'] = "public, must-revalidate, 
	    max-age=3600, s-maxage=3600";
        break;

        case "cache-control-override":
            $headers['Expires'] = toUTCDate($expires_date);
            $headers['Cache-Control'] = "public, must-revalidate, 
	    max-age=2, s-maxage=2";
        break;

        case "last-modified":
            $headers['Last-Modified'] = LAST_MODIFIED_STRING;
            $headers['Etag'] = md5( 12345 );

            if( isset( $_SERVER['HTTP_IF_MODIFIED_SINCE'] ) and
                $_SERVER['HTTP_IF_MODIFIED_SINCE'] == 
		LAST_MODIFIED_STRING ) {
                header( "HTTP/1.1 304 Not Modified" );
                exit(  );
            }
        break;

        case "vary":
            $headers['Expires'] = toUTCDate($expires_date);
            $headers['Vary'] = 'User-Agent';
        break;
    }

    sendHeaders( $headers );
}

function sendHeaders( array $headerList )
{
    foreach( $headerList as $name => $value )
    {
        header( "${name}: ${value}" );
    }
}

function toUTCDate( DateTime $date )
{
    $date->setTimezone( new DateTimeZone( 'UTC' ) );
    return $date->format( 'D, d M Y H:i:s \G\M\T' );
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head></head>
    <body>
        <h1>Header fields sent:</h1>
        <?php
            foreach( $headers as $name => $value ) {
                print "<strong>${name}</strong>: ${value}<br/>";
            }

            if( isset( $_SERVER['HTTP_IF_MODIFIED_SINCE'] ) ) {
                print "<strong>If-Modified-Since</strong> has been 
		sent in the";
                print "request, value : " . 
		$_SERVER['HTTP_IF_MODIFIED_SINCE'];
            }
        ?>
        <hr/>
        <h1>Links for testing</h1>
        <ol>
            <li><a href="<?=$_SERVER['PHP_SELF']?>?h=expires">
	    Test Expires response header field</a></li>
            <li><a href="<?=$_SERVER['PHP_SELF']?>?h=cache-control">
	    Test Cache-Control response header field</a></li>
            <li><a href="<?=$_SERVER['PHP_SELF']?>?
	    h=cache-control-override">
	    Test Cache-Control and Expires</a></li>
            <li><a href="<?=$_SERVER['PHP_SELF']?>?h=last-modified">
	    Test Last-Modified/If-Modified-Since response header fields</a></li>
            <li><a href="<?=$_SERVER['PHP_SELF']?>?h=vary">
	    Test Vary response header field</a></li>
        <ol>
    </body>
</html>
