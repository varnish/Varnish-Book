sub vcl_hit {
    return (deliver);
}
