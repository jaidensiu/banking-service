# Gopher Bank

## Database Schema

![Database schema](images/database_schema.png)

## Docker Commands

List running containers:
- `docker ps`

List all containers:
- `docker ps -a`

List all available images:
- `docker images`

Pull an image:
- `docker pull <image>:<tag>`

Create and start a container:
- `docker run --name <container_name> -e <environment_variable> -d <image_name>:<tag>`

Start a container:
- `docker start <container_name_or_id>`

Stop a container:
- `docker stop <container_name_or_id>`

Remove a container:
- `docker rm <container_name_or_id>`

Port mapping:
- `docker run --name <container_name> -e <environment_variable> -p <host_ports:container_ports> -d <image>:<tag>`

Run command in container:
- `docker exec -it <container_name_or_id> <command> [args]`

Access container shell:
- `docker exec -it <container_name_or_id> /bin/sh`

View container logs:
- `docker logs <container_name_or_id>`

## Tools and References

- [DBDiagram](https://dbdiagram.io/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Docker Postgres Image](https://hub.docker.com/_/postgres)
- [TablePlus](https://tableplus.com/)
- [Golang-Migrate](https://github.com/golang-migrate/migrate)
- [sqlc](https://sqlc.dev/)
- [Go Postgres Database Driver](https://github.com/lib/pq)
- [Testify](https://github.com/stretchr/testify)
- [GitHub Actions PostgreSQL Service Containers](https://docs.github.com/en/actions/using-containerized-services/creating-postgresql-service-containers)
- [Gin](https://github.com/gin-gonic/gin)
- [Viper](https://github.com/spf13/viper)