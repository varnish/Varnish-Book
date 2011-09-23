sub vcl_fetch {
	if (beresp.http.cache-control !~ "s-maxage") {
		if (req.url ~ "\.jpg(\?|$)") {
			set beresp.ttl = 30s;
			unset beresp.http.Set-Cookie;
		}
		if (req.url ~ "\.html(\?|$)") {
			set beresp.ttl = 10s;
			unset beresp.http.Set-Cookie;
		}
	} else {
		if (beresp.ttl > 0s) {
			unset beresp.http.Set-Cookie;
		}
	}
}
