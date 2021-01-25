#!/bin/bash

@docker exec -it genero_db_1 bash -c "psql -U $${POSTGRES_USER} -d $${POSTGRES_USER} -c 'DROP DATABASE IF EXISTS '$${DB_NAME}"

