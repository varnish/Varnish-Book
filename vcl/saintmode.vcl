vcl 4.0;

import saintmode;
import directors;

backend server1 { .host = "192.0.2.11"; .port = "80"; }
backend server2 { .host = "192.0.2.12"; .port = "80"; }

sub vcl_init {
        # create two saint mode backends with threshold of 5 blacklisted objects
        new sm1 = saintmode.saintmode(server1, 5);
        new sm2 = saintmode.saintmode(server2, 5);

        # group the backends in the same cluster
        new fb = directors.fallback();
        fb.add_backend(sm1.backend());
        fb.add_backend(sm2.backend());
}

sub vcl_backend_fetch {
        # get healthy backend from director
        set bereq.backend = fb.backend();
}

sub vcl_backend_response {
        if (beresp.status > 500) {
                # the failing backend is blacklisted 5 seconds
                saintmode.blacklist(5s);
                # retry request in a different backend
                return (retry);
        }
}