#!/bin/bash

# Set the database name and SQLAlchemy URI
DB_NAME="reddit"
SQLALCHEMY_URI="postgresql+psycopg2://postgres:password@postgres2/reddit"

# Check if the database already exists using the Superset CLI and Superset's Python API
EXISTING_DB=$(superset list_databases | grep "$DB_NAME")

if [ -z "$EXISTING_DB" ]; then
    echo "Database '$DB_NAME' does not exist. Adding it now..."
    superset set_database_uri --database_name $DB_NAME --uri $SQLALCHEMY_URI
else
    echo "Database '$DB_NAME' already exists. Skipping creation."
fi
