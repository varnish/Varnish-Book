sub vcl_backend_response {
	if (bereq.url ~ "\.jpg$") {
		set beresp.ttl = 60s;
	}
}
