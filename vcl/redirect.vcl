sub vcl_recv {
    if (req.http.host == "www.example.com") {
        set req.http.Location = "http://example.com" + req.url;
        return (synth(750, "Permanently moved"));
    }
}

sub vcl_synth {
    if (resp.status == 750) {
        set resp.http.location = req.http.Location;
        set resp.status = 301;
        return (deliver);
    }
}
