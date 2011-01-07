sub vcl_fetch {
	if (beresp.http.cache-control ~ "(no-cache|private)" ||
		beresp.http.pragma ~ "no-cache") {
		set beresp.cacheable = false;
	}
}
