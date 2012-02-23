backend default {
    .host = "localhost";
    .port = "80";
}

acl purge {
    "127.0.0.1";
}

sub vcl_recv {

    if (req.request == "PURGE") {
        if (!client.ip ~ purge) {
            error 405 "Not allowed.";
        }
        purge("req.url == " req.url " && req.http.host == " req.http.host);
        error 200 "Purged.";
    }
    /* [...] */
}
