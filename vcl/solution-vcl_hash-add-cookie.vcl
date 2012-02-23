sub vcl_hash {
    set req.hash += req.http.Cookie;
}

sub vcl_recv {

    /* [...] */

    return (lookup);
}
