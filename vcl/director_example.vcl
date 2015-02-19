vcl 4.0;

import directors;    // load the directors

backend one {
   .host = "localhost";
   .port = "80";
}

backend two {
   .host = "127.0.0.1";
   .port = "81";
}

sub vcl_init{
   new round_robin_director = directors.round_robin();
   round_robin_director.add_backend(one);
   round_robin_director.add_backend(two);

   new random_director = directors.random();
   random_director.add_backend(one, 10);  # 2/3 to backend one
   random_director.add_backend(two, 5);   # 1/3 to backend two
}

sub vcl_recv {
	set req.backend_hint = round_robin_director.backend();
}
