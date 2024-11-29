## What is Docker?

Docker is a platform that enables developers to build, deploy, and run applications inside containers. Containers are lightweight, portable, and self-sufficient units that include everything needed to run an application, such as code, runtime, libraries, and system tools.

## Docker images

Docker images are read-only templates that contain the instructions to create a Docker container. They are a snapshot or blueprint of the libraries, dependencies, and application code required inside a container.

Images are used to build containers. They can be pulled from Docker Hub or other container registries, or built from a Dockerfile.

## Docker containers

A Docker container is a lightweight, standalone, executable package of software that includes everything needed to run an application. Containers are instances of Docker images.

Containers run in isolation from each other and the host system, ensuring that applications run consistently regardless of the environment.

Containers are portable meaning that they can be easily moved between different environments, such as development, testing, and production.

We can think of a container as an instance of the application contained in the image.

## Dockerfile

A text file that contains a series of instructions on how to build a Docker image. It specifies the base image, application code, dependencies, and commands to run.

## Docker Hub

A cloud-based registry service where Docker images can be stored, shared, and managed. It provides access to a vast library of pre-built images.

## Docker Compose

A tool for defining and running multi-container Docker applications. It uses a YAML file to configure the application's services, networks, and volumes.

## Basic Docker commands

Pull/download an image from a registry
```
docker pull <image>:<tag>
```

Create an image from a Dockerfile
```
docker build -t <image_name>:<tag> <path_to_dockerfile>
```

Create and start a container from an image
```
docker run --name <container_name> -e <environment_variable> -d <image>:<tag>
```

List running containers (add `-a` to list all containers)
```
docker ps
```

Stop a container
```
docker stop <container_name_or_id>
```

Remove a stopped container
```
docker rm <container_name_or_id>
```

Display the logs of a container
```
docker logs <container_name_or_id>
```

## What is a middleware?

A middleware is a function that intercepts and processes requests before they reach the main handler in a web application. When a client sends a request to a specific API route on the server, the request will first pass through one or more middleware functions (such as logging or authentication middleware).

Middleware functions are similar to handler functions and accept a single `gin.Context` input argument. However, middleware can also abort a request and send a response to the client without forwarding it to the main handler function.

For an authentication middleware, we can:

1. Parse and check if the access token is valid.
2. If the token is invalid or expired, call `ctx.Abort()` to stop the request and send a 401 status to the client.
3. If the token is valid, store the parsed token payload in the context and call `ctx.Next()` to forward the request to the next middleware or handler.

The handler will then read the token payload from the context to identify the user and determine what actions they are authorized to perform and what data can be returned to the client.
