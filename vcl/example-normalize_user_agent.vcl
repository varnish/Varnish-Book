sub vcl_recv {
    if (req.http.User-Agent ~ "iPad" ||
        req.http.User-Agent ~ "iPhone" ||
        req.http.User-Agent ~ "Android") {

        set req.http.X-Device = "mobile";
    } else {
        set req.http.X-Device = "desktop";
    }
}
