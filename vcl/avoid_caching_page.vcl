sub vcl_fetch {
    if (req.url ~ "index.html") { return(hit_for_pass); }
}

# Or::

sub vcl_recv {
    if (req.url ~ "index.html") { return(pass); }
}
