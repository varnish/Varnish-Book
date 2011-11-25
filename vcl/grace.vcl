sub vcl_recv {
	if (req.backend.healthy) {
		set req.grace = 30s;
	} else {
		set req.grace = 24h;
	}
}

sub vcl_fetch {
	set beresp.grace = 24h;
}
