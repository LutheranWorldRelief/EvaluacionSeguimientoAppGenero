#!/bin/bash

docker exec -it genero_db_1 bash -c "pg_dump -U $${POSTGRES_USER} $${DB_NAME} > /tmp/backup/\"$$(date +'%%Y%%m%%d%%H%%M%%S')_$${DB_NAME}.sql\""
