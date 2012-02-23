sub vcl_recv {

    if( req.http.Cookie ) {
        // removes the "bankaccount" cookie
        // but keeps the "user" one
        set req.http.Cookie = regsub(
            req.http.Cookie, ";bankaccount=[\d]+", ""
        );
    }

    /* [...] */
}
