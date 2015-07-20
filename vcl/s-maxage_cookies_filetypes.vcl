sub vcl_backend_response {
    if (beresp.http.cache-control !~ "s-maxage") {
        if (bereq.url ~ "\.jpg(\?|$)") {
            set beresp.ttl = 30s;
            unset beresp.http.Set-Cookie;
        }
        if (bereq.url ~ "\.html(\?|$)") {
            set beresp.ttl = 10s;
            unset beresp.http.Set-Cookie;
        }
    } else {
        if (beresp.ttl > 0s) {
            unset beresp.http.Set-Cookie;
        }
    }
}
