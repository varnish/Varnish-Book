sub vcl_hit {
  // If objects remaining TTL is at least 0, we have a fresh enough object
  if (obj.ttl >= 0s) {
    // normal hit
    return (deliver);
  }
  // checks the backend health
  else if (std.healthy(req.backend_hint)) {
      return(fetch);
  }
  // No fresh object and the backend is down
  else{
    // Deliver graced object
    if (obj.ttl + obj.grace > 0s) {
      return (deliver);
    } else {
      return (synth(500, "Backend is down"));
   }
  }
}

