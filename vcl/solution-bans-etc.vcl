sub vcl_recv {
    if (req.method == "PURGE") {
       return (purge);
    }

    if (req.method == "BAN") {
       ban("obj.http.x-url ~ " + req.http.x-ban-url +
           " && obj.http.x-host ~ " + req.http.x-ban-host);
           return(synth(200, "Ban added"));
    }

    if (req.method == "REFRESH") {
       set req.method = "GET";
       set req.hash_always_miss = true;
    }
}

sub vcl_backend_response {
   set beresp.http.x-url = bereq.url;
   set beresp.http.x-host = bereq.http.host;
}

sub vcl_deliver {
   unset resp.http.x-url; # Optional
}
