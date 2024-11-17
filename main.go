package main

import (
	"database/sql"
	"log"

	_ "github.com/golang/mock/mockgen/model"
	"github.com/jaidensiu/simple-bank/api"
	db "github.com/jaidensiu/simple-bank/db/sqlc"
	"github.com/jaidensiu/simple-bank/util"
	_ "github.com/lib/pq"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("Cannot load config:", err)
	}
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("Cannot connect to db: ", err)
	}
	store := db.NewStore(conn)
	server := api.NewServer(store)
	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("Cannot start server:", err)
	}
}
