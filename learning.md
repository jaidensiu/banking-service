## What is a middleware?

A middleware is a function that intercepts and processes requests before they reach the main handler in a web application. When a client sends a request to a specific API route on the server, the request will first pass through one or more middleware functions (such as logging or authentication middleware).

Middleware functions are similar to handler functions and accept a single `gin.Context` input argument. However, middleware can also abort a request and send a response to the client without forwarding it to the main handler function.

For an authentication middleware, we can:

1. Parse and check if the access token is valid.
2. If the token is invalid or expired, call `ctx.Abort()` to stop the request and send a 401 status to the client.
3. If the token is valid, store the parsed token payload in the context and call `ctx.Next()` to forward the request to the next middleware or handler.

The handler will then read the token payload from the context to identify the user and determine what actions they are authorized to perform and what data can be returned to the client.
