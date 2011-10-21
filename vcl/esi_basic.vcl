sub vcl_fetch {
	set beresp.do_esi = true;
}
