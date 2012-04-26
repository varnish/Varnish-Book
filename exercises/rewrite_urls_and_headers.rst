

#. Copy the original `Host`-header (``req.http.Host``) and URL
   (``req.url``) to two new request header of your choice. E.g:
   ``req.http.x-host`` and ``req.http.x-url``.
#. Ensure that `www.example.com` and `example.com` are cached as one, using
   ``regsub()``.
#. Rewrite all URLs under `http://sport.example.com` to
   `http://example.com/sport/`. For example:
   `http://sport.example.com/article1.html` to
   `http://example.com/sport/article1.html`.
#. Use varnishlog to verify the result.

Extra: Make sure `/` and `/index.html` is cached as one object. How can you
verify that it is, without changing the content?

Extra 2: Make the redirection work for any domain with `sport.` at the
front. E.g: `sport.example.com`, `sport.foobar.example.net`,
`sport.blatti`, etc.

