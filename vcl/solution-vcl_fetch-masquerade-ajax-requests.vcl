backend google {
    .host = "209.85.147.106";
    .port = "80";
}

sub vcl_fetch {
    if (req.url ~ "^/masq") {
        set req.backend = google;
        set req.http.host = "www.google.com";
        set req.url = regsub(req.url, "^/masq", "");
        remove req.http.Cookie;
        return(deliver);
    }
    /* [...] */
}
