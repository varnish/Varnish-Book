sub vcl_fetch {
	if (req.url ~ "\.jpg$") {
		set beresp.ttl = 60s;
	}
}
