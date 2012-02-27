backend default { .host = "localhost"; .port = "80"; }
acl purgers { "127.0.0.1"; }
sub vcl_recv {
    if (req.request == "PURGE") {
        if (!client.ip ~ purgers) {
            error 405 "Not allowed.";
        }
	return (lookup);
    }
}
sub vcl_hit {
	if (req.request == "PURGE") {
		purge;
		error 200 "Purged.";
	}
}
sub vcl_miss {
	if (req.request == "PURGE") {
		purge;
		error 200 "Purged.";
	}
}
