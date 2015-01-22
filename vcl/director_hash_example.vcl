sub vcl_init {
    new h = directors.hash();
    h.add_backend(one, 1);   // backend 'one' with weight '1'
    h.add_backend(two, 1);   // backend 'two' with weight '1'
}

sub vcl_recv {
    // pick a backend based on the cookie header of the client
    set req.backend_hint = h.backend(req.http.cookie);
}
