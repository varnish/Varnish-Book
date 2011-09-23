sub vcl_fetch {
    if (beresp.ttl <= 0s ||
        beresp.http.Set-Cookie ||
        beresp.http.Vary == "*") {
		/*
		 * Mark as "Hit-For-Pass" for the next 2 minutes
		 */
		set beresp.ttl = 120 s;
		return (hit_for_pass);
    }
    return (deliver);
}
