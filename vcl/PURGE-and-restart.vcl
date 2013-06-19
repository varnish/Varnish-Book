acl purgers {
	"127.0.0.1";
	"192.168.0.0"/24;
}

sub vcl_recv {
	if (req.restarts == 0) {
		unset req.http.X-purger;
	}
	if (req.request == "PURGE") {
		if (!client.ip ~ purgers) {
			error 405 "Method not allowed";
		}
		return (lookup);
	}
}

sub vcl_hit {
	if (req.request == "PURGE") {
		purge;
		set req.request = "GET";
		set req.http.X-purger = "Purged";
		error 800 "restart";
	}
}

sub vcl_miss {
	if (req.request == "PURGE") {
		purge;
		set req.request = "GET";
		set req.http.X-purger = "Purged-possibly";
		error 800 "restart";    # cant restart in miss, yet. go via error
	}
}

sub vcl_error {
	if (obj.status == 800 ) {
		return(restart);
	}
}

sub vcl_pass {
	if (req.request == "PURGE") {
		error 502 "PURGE on a passed object";
	}
}

sub vcl_deliver {
	if (req.http.X-purger) {
		set resp.http.X-purger = req.http.X-purger;
	}
}
