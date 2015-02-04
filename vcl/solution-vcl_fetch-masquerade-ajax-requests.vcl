vcl 4.0;

import std;

backend localhost{
    .host = "127.0.0.1";
    .port = "8080";
}

backend google {
    .host = "173.194.112.145";
    .port = "80";
}


sub vcl_recv{
    if (req.url ~ "^/masq") {
        set req.backend_hint = google;
        set req.http.host = "www.google.com";
        set req.url = regsub(req.url, "^/masq", "");
        return (hash);
    }else{
        set req.backend_hint = localhost;
    }
}

/*sub vcl_backend_fetch {
    if (bereq.url ~ "^/masq") {
        set bereq.backend = google;
        set bereq.http.host = "www.google.com";
        set bereq.url = regsub(bereq.url, "^/masq", "");
        return (fetch);
    }
}
*/