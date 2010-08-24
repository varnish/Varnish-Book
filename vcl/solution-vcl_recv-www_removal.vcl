sub vcl_recv {
        set req.http.x-host = req.http.host;
        set req.http.host = regsub(req.http.host, "^www\.", "");
}
