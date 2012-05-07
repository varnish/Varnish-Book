backend normal {
	.host = "localhost";
	.probe = { .url = "/"; }
}

backend fail {
	.host = "localhost";
	.port = "21121";
	.probe = { .url = "/asfasfasf"; .initial = 0; .interval = 1d; }
}

sub vcl_recv {
	if (req.restarts == 0) {
		set req.backend = normal;
	} else {
		set req.backend = fail;
	}

	if (req.backend.healthy) {
		set req.grace = 30s;
	} else {
		set req.grace = 24h;
	}
}

sub vcl_fetch {
	set beresp.grace = 24h;
}

sub vcl_error {
	if (req.restarts == 0) {
		return (restart);
	}
}
