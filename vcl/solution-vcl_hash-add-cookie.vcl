sub vcl_hash {
    hash_data(req.http.Cookie);
}

sub vcl_recv {

    /* [...] */

    return (lookup);
}
