backend default {
    .host = "localhost";
    .port = "80";
}

acl banners {
    "127.0.0.1";
}

sub vcl_recv {

    if (req.request == "PURGE") {
        if (!client.ip ~ banners) {
            error 405 "Not allowed.";
        }
        ban("req.url == " + req.url + " && req.http.host == " + req.http.host);
        error 200 "Banned.";
    }
    /* [...] */
}
