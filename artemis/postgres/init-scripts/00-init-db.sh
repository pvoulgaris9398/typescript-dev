#!/bin/bash
set -e

# Fallback defaults if variables are missing
APP_DB="${APP_DB_NAME:-my_app_db}"
APP_USER="${APP_DB_USER:-my_app_user}"
APP_PASS="${APP_DB_PASS:-my_secure_password}"
APP_SCHEMA="${APP_SCHEMA_NAME:-my_default_schema}"

echo "Step 1: Provisioning database '$APP_DB' and user '$APP_USER'..."
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER $APP_USER WITH PASSWORD '$APP_PASS';
    CREATE DATABASE $APP_DB WITH OWNER $APP_USER;
    GRANT ALL PRIVILEGES ON DATABASE $APP_DB TO $APP_USER;
EOSQL

echo "Step 2: Executing existing SQL scripts as '$APP_USER'..."
SCRIPT_DIR="/docker-entrypoint-initdb.d"

for sql_file in $(ls "$SCRIPT_DIR"/*.sql 2>/dev/null | sort); do
    echo "Executing script: $(basename "$sql_file")"
    
    # Pass the bash variable into psql as a psql variable named 'schema_name'
    PGPASSWORD="$APP_PASS" psql -v ON_ERROR_STOP=1 \
        --username "$APP_USER" \
        --dbname "$APP_DB" \
        -v schema_name="$APP_SCHEMA" \
        -f "$sql_file"
done

echo "Database initialization successfully completed!"
