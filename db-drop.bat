@docker exec -it genero_db_1 bash -c "psql -U ${POSTGRES_USER} -d ${DB_NAME} -c 'DROP DATABASE IF EXISTS '${DB_NAME}"
