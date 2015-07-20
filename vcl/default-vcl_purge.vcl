sub vcl_purge {
    return (synth(200, "Purged"));
}