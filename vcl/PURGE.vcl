acl purgers {
	"127.0.0.1";
	"192.168.0.0"/24;
}

sub vcl_recv {
	if (req.request == "PURGE") {
		if (!client.ip ~ purgers) {
			error 405 "Method not allowed";
		}
		return (lookup);
	}
}

sub vcl_hit {
	if (req.request == "PURGE") {
		set obj.ttl = 0s;
		error 200 "Purged";
	}
}
sub vcl_miss {
	if (req.request == "PURGE") { 
		error 404 "Not in cache";
	}
}
sub vcl_pass {
	if (req.request == "PURGE") {
		error 502 "PURGE on a passed object";
	}
}
