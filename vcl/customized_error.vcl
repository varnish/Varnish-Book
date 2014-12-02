/* Change your backend configuration to provoke a 503 error */
backend default {
    .host = "127.0.0.1";
    .port = "8081";
}

/* This exercise is still not working */
sub vcl_synth {
    if(resp.status == 503){
    synthetic( {"
      <html><body><!-- Here goes a more friendly error message. --></body></html>
    "} );
    set resp.status = 200;

    return (deliver);
    }
}
