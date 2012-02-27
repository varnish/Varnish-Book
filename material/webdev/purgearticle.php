<?php
header( 'Content-Type: text/plain' );
$hostname = 'localhost';
$port     = 8000;
$URL      = '/url/to/article.php';
$debug    = true;

print "Updating the article in the database ...\n";
purgeURL( $hostname, $port, $URL, $debug );

function purgeURL( $hostname, $port, $purgeURL, $debug )
{
    $finalURL = sprintf(
        "http://%s:%d%s", $hostname, $port, $purgeURL
    );

    print( "Purging ${finalURL}\n" );

    $curlOptionList = array(
        CURLOPT_RETURNTRANSFER    => true,
        CURLOPT_CUSTOMREQUEST     => 'PURGE',
        CURLOPT_HEADER            => true ,
        CURLOPT_NOBODY            => true,
        CURLOPT_URL               => $finalURL,
        CURLOPT_CONNECTTIMEOUT_MS => 2000
    );

    $fd = false;
    if( $debug == true )
    {
        print "\n---- Curl debug -----\n";
        $fd = fopen("php://output", 'w+');
        $curlOptionList[CURLOPT_VERBOSE] = true;
        $curlOptionList[CURLOPT_STDERR]  = $fd;
    }

    $curlHandler = curl_init();
    curl_setopt_array( $curlHandler, $curlOptionList );
    curl_exec( $curlHandler );
    curl_close( $curlHandler );
    if( $fd !== false )
    {
        fclose( $fd );
    }
}
?>
