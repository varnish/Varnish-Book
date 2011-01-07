sub vcl_fetch {
	if (req.restarts == 0 &&
		 req.request == "GET" &&
		 beresp.status == 301) {
		set beresp.http.location = regsub(beresp.http.location,"^http://","");
		set req.http.host = regsub(beresp.http.location,"/.*$","");
		set req.url = regsub(beresp.http.location,"[^/]*","");
		return (restart);
	}
}
