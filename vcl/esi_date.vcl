sub vcl_backend_response {
    if (bereq.url == "/esi-date.php") {
       set beresp.do_esi = true;   // Do ESI processing
       set beresp.ttl = 1m;        // Sets the TTL on the HTML above
    } else if (bereq.url == "/cgi-bin/esi-date.cgi") {
       set beresp.ttl = 30s;       // Sets a one minute TTL on
                                   // the included object
    }
}
