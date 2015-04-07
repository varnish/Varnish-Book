import directors;

probe www_probe {
    .url = "/health";
}

backend www1 {
    .host = "localhost";
    .port = "8081";
    .probe = www_probe;
}

backend www2 {
    .host = "localhost";
    .port = "8082";
    .probe = www_probe;
}

sub vcl_init {
    new www = directors.round_robin();
    www.add_backend(www1);
    www.add_backend(www2);
}
