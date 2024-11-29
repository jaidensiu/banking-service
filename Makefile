# Start a PostgreSQL container
postgres:
	docker run --name banking_service_container -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

# Create a new database inside a PostgreSQL container
createdb:
	docker exec -it banking_service_container createdb --username=root --owner=root banking_service_db

# Drop the database inside the PostgreSQL container
dropdb:
	docker exec -it banking_service_container dropdb banking_service_db

# Access the PostgreSQL database using psql
accessdb:
	docker exec -it banking_service_container psql -U root -d banking_service_db

# Apply all up migrations
migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/banking_service_db?sslmode=disable" -verbose up

# Apply one up migration
migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/banking_service_db?sslmode=disable" -verbose up 1

# Apply all down migrations
migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/banking_service_db?sslmode=disable" -verbose down

# Apply one down migration
migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/banking_service_db?sslmode=disable" -verbose down 1

# Generate SQL code using sqlc
sqlc:
	sqlc generate

# Run all tests with coverage
test:
	go test -v -cover ./...

# Run the Go server
server:
	go run main.go

# Generate mock implementations for the database
mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/jaidensiu/banking-service/db/sqlc Store

# Phony target declarations
.PHONY: postgres createdb dropdb accessdb migrateup migrateup1 migratedown migratedown1 sqlc server mock
