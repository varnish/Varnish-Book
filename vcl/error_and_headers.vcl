sub vcl_error {
	synthetic "<html><body><!-- Blank page must means it's a browser issue! --></body></html>";
	set obj.status = 200;
	return (deliver);
}

sub vcl_deliver {
	set resp.http.X-Age = resp.http.Age;
	unset resp.http.Age;

	if (obj.hits > 0) {
		set resp.http.X-Cache = "HIT";
	} else {
		set resp.http.X-Cache = "MISS";
	}
}
