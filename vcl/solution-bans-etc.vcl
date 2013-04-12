sub vcl_recv {
	if (req.request == "PURGE") {
		return (lookup);
	}
	if (req.request == "BAN") {
		ban("obj.http.x-url ~ " + req.http.x-ban-url +
		    " && obj.http.x-host ~ " + req.http.x-ban-host);
		error 200 "Banned";
	}
	if (req.request == "REFRESH") {
		set req.request = "GET";
		set req.hash_always_miss = true;
	}
}

sub vcl_hit {
	if (req.request == "PURGE") {
		purge;
		error 200 "Purged";
	}
}

sub vcl_miss {
	if (req.request == "PURGE") {
		purge;
		error 404 "Not in cache";
	}
}

sub vcl_fetch {
	set beresp.http.x-url = req.url;
	set beresp.http.x-host = req.http.host;
}

sub vcl_deliver {
	unset resp.http.x-url;
	unset resp.http.x-host;
}
