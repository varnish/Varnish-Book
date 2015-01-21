sub vcl_hit {
  if (obj.ttl >= 0s) {
    // Normal hit
    return (deliver);
  }
  else if (std.healthy(req.backend_hint)) {
     // The backend is healthy
     // Fetch the object from the backend
     return(fetch);
  }
  else{
    // No fresh object and the backend is not healthy
    if (obj.ttl + obj.grace > 0s) {
      // Deliver graced object
      // Automatically triggers a background fetch
      return (deliver);
    } else {
      // No valid object to deliver
      // No healthy backend to handle request
      // Return error
      return (synth(500, "Backend is down"));
   }
  }
}
