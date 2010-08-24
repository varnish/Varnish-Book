sub vcl_recv {
	if (req.http.Accept-Encoding) {
		if (req.http.Accept-Encoding ~ "gzip") {
			set req.http.Accept-Encoding = "gzip";
		} elsif (req.http.Accept-Encoding ~ "deflate") {
			set req.http.Accept-Encoding = "deflate";
		} else {
			remove req.http.Accept-Encoding;
		}
	}
}
