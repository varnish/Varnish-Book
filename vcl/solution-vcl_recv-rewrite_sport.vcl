sub vcl_recv {
        if (req.http.host == "sport.example.com") {
                set req.http.host = "example.com";
                set req.url = regsub(req.url, "^", "/sport");
        }
}
