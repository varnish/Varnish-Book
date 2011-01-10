director mydirector dns {
	.list = {
		.port = "81";
		"192.168.0.0"/24;
	}
	.ttl = 5m;
	.suffix = "internal.example.net";
}

sub vcl_recv {
	set req.backend = mydirector;
}
