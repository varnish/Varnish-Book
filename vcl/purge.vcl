sub vcl_recv {
    if (req.method == "PURGE")
        return (purge);
}
