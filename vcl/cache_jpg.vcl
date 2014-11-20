sub vcl_back_response {
	if (req.url ~ "\.jpg$") {
		set beresp.ttl = 60s;
	}
}
