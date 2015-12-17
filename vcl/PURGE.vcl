# Allow PURGE from localhost and 192.168.0.0/24
acl purgers {
    "127.0.0.1";
    "192.168.0.0"/24;
}

sub vcl_recv {
    if (req.method == "PURGE") {
        if (!client.ip ~ purgers) {
            return (synth(405));
        }
        return (purge);
    }
}
