sub vcl_fetch {
    if (req.url ~ "wiki\.pl") { return(hit_for_pass); }
}

# Or::

sub vcl_recv {
    if (req.url ~ "wiki\.pl") { return(pass); }
}
