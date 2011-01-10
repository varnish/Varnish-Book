backend normalbackend {
	.host = "localhost";
}

director backenddirector round-robin {
	{ .backend = { .host = "localhost"; } }
}

sub vcl_recv {
	if (req.url ~ "usebackend") {
		set req.backend = normalbackend;
	} else {
		set req.backend = backenddirector;
	}
}
