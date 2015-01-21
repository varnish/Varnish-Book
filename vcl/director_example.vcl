import directors;    // load the directors

backend one {
   .host = "localhost";
   .port = "80";
}

backend two {
   .host = "127.0.0.1";
   .port = "81";
}

director localhosts round-robin {
   { .backend = one; }
   { .backend = two; }
   { .backend = { .host = "localhost"; .port = "82"; } }
}

sub vcl_recv {
	set req.backend_hint = localhosts;
}
