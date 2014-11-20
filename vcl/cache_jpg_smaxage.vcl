sub vcl_backend_response {
	if (beresp.http.cache-control !~ "s-maxage" && req.url ~ "\.jpg$") {
		set beresp.ttl = 60s;
	}
}
