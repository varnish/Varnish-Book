// Yes, it is that simple :)
sub vcl_fetch {
    esi;
    /* [...] */
}

/* And if you want to avoid esi.php to get cached */
sub vcl_recv {

    if ( req.url ~ "/esi.php" ) {
        return (pass);
    }

    /* [...] */
}