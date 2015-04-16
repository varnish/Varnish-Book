sub vcl_backend_response {
    if (bereq.url == "/esi-date.php") {
       set beresp.do_esi = true;   // Do ESI processing
       set beresp.ttl = 1m;        // Sets a higher TTL main object
    } elsif (bereq.url == "/cgi-bin/esi-date.cgi") {
       set beresp.ttl = 30s;       // Sets a lower TTL on
                                   // the included object
    }
}
