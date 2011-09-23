sub vcl_recv {
	if (req.http.host == "www.example.com") {
		set req.http.Location = "http://example.com" + req.url;
		error 750 "Permanently moved";
	}
}

sub vcl_error {
	if (obj.status == 750) {
		set obj.http.location = req.http.Location;
		set obj.status = 301;
		return (deliver);
	}
}
