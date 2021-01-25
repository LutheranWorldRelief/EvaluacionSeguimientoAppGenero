#!/bin/bash

docker-compose run genero_db_1 bash -c "psql -U ${POSTGRES_USER} -d ${POSTGRES_USER} -f /tmp/backup/${DB_RESTORE}"
