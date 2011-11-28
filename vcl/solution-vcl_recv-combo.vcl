
sub vcl_recv {
        set req.http.x-host = req.http.host;
	set req.http.x-url = req.url;
        set req.http.host = regsub(req.http.host, "^www\.", "");

	if (req.http.host == "sport.example.com") {
                set req.http.host = "example.com";
                set req.url = regsub(req.url, "^", "/sport");
        }
	
	// Or:

        if (req.http.host ~ "^sport\.") {
                set req.http.host = regsub(req.http.host,"^sport\.", "");
                set req.url = regsub(req.url, "^", "/sport");
        }
}
