backend one {
	.host = "example.com";
	.probe = {
		.request = 
			"GET / HTTP/1.1"
			"Host: www.foo.bar"
			"Connection: close";
	}
}
