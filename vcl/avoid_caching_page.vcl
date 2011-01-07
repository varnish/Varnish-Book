sub vcl_fetch {
    if (req.url ~ "wiki\.pl") { return(pass); }
}

# Or::

sub vcl_recv {
    if (req.url ~ "wiki\.pl") { return(pass); }
}
