acl management {
	"172.16.0.0"/16;
}

acl sysadmins {
	"192.168.0.0"/16;
	! "192.168.0.1";
}

sub vcl_recv {
	if (client.ip ~ management) {
		set req.url = regsub(req.url, "^","/proper-stuff");
	} elsif (client.ip ~ sysadmins) {
		set req.url = regsub(req.url, "^","/cool-stuff");
	}
}
