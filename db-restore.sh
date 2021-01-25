#!/bin/bash

docker exec -it genero_db_1 bash -c "psql -U ${POSTGRES_USER} -d ${POSTGRES_USER} -c 'CREATE DATABASE '${DB_NAME}"
docker exec -it genero_db_1 bash -c "psql -h localhost -U ${POSTGRES_USER} -d ${DB_NAME} -f /tmp/backup/${DB_RESTORE_FILE}"
