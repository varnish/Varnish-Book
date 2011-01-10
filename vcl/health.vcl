backend one {
	.host = "example.com";
	.probe = {
		.url = "/healthtest";
		.interval = 3s;
		.window = 5;
		.threshold = 2;
	}
}
