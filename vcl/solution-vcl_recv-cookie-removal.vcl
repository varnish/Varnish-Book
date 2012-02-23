sub vcl_recv {

    if( req.http.Cookie ) {
        unset req.http.Cookie;
    }

    /* [...] */
}