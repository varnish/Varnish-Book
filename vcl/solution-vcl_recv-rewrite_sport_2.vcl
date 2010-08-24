sub vcl_recv {
        if (req.http.host ~ "^sport\.") {
                set req.http.host = regsub(req.http.host,"^sport\.", "");
                set req.url = regsub(req.url, "^", "/sport");
        }
}
