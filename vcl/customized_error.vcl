vcl 4.0;

/* Change your backend configuration to provoke a 503 error */
backend default {
  .host = "127.0.0.1";
  .port = "8081";
}

/* Customize error responses */
sub vcl_backend_error {
  if(beresp.status == 503){
     set beresp.status = 200;
     synthetic( {"
        <html><body><!-- Here goes a more friendly error message. --></body></html>
     "});
     return (deliver);
  }
}
