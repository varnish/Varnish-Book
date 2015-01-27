acl purgers {
	"127.0.0.1";
	"192.168.0.0"/24;
}

sub vcl_recv {
    # allow PURGE from localhost and 192.168.55...

    if (req.method == "PURGE") {
      if (!client.ip ~ purgers) {
           return(synth(405,"Not allowed."));
         }
         return (purge);
       }
}
