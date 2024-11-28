postgres:
	docker run --name banking_service_container -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it banking_service_container createdb --username=root --owner=root banking_service_db

dropdb:
	docker exec -it banking_service_container dropdb banking_service_db

accessdb:
	docker exec -it banking_service_container psql -U root -d banking_service_db

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/banking_service_db?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/banking_service_db?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/banking_service_db?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/banking_service_db?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/jaidensiu/banking-service/db/sqlc Store

.PHONY: postgres createdb dropdb accessdb migrateup migrateup1 migratedown migratedown1 sqlc server mock
