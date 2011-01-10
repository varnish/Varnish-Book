director randomtest random {
	.retries = 3;
	{ .backend = { .host = "example.com"; .port = "81"; } .weight = 5; }
	{ .backend = { .host = "localhost"; } .weight = 10; }
}
