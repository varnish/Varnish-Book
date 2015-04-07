acl purgers {
        "127.0.0.1";
        "192.168.0.0"/24;
}

sub vcl_recv {
    # allow PURGE from localhost and 192.168.55...
    if (req.restarts == 0) {
                unset req.http.X-purger;
    }

    if (req.method == "PURGE") {
      if (!client.ip ~ purgers) {
           return(synth(405, "Purging not allowed for " + client.ip));
      }
      return (purge);
    }
}

sub vcl_purge {
   set req.method = "GET";
   set req.http.X-purger = "Purged";
   return (restart);
}
