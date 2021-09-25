#!/bin/bash

docker-compose exec db bash -c "psql -U \${POSTGRES_USER} -d \${DB_NAME} -c 'DROP DATABASE IF EXISTS '\${DB_NAME}"

