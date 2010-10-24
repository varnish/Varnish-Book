sub vcl_hit {
    if (!obj.cacheable) {
        return (pass);
    }
    return (deliver);
}
