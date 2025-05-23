#!/bin/bash

# Run this script to set up the environment variables and start the project
export AIRFLOW_UID=$(id -u)

echo "AIRFLOW_UID=$(id -u)" > .env

# Append the rest of the environment variables
echo AIRFLOW__CORE__EXECUTOR=LocalExecutor >> .env
echo AIRFLOW__DATABASE__SQL_ALCHEMY_CONN=postgresql+psycopg2://postgres:postgres@postgres:5432/airflow_reddit >> .env
echo AIRFLOW__CORE__FERNET_KEY=46BKJoQYlPPOexq0OhDZnIlNepKFf87WFwLbfzqDDho= >> .env
echo AIRFLOW__CORE__LOGGING_LEVEL=INFO >> .env
echo AIRFLOW__CORE__LOAD_EXAMPLES=False >> .env
echo _AIRFLOW_DB_MIGRATE: 'true' >> .env
echo _AIRFLOW_WWW_USER_CREATE: 'true' >> .env
echo _AIRFLOW_WWW_USER_USERNAME: 'admin' >> .env
echo _AIRFLOW_WWW_USER_PASSWORD: 'admin' >> .env

echo "Initializing Airflow database..."
docker-compose up airflow-init

echo "Building the docker containers..."
docker-compose build

echo "Starting docker containers in detached mode "
docker-compose up -d

echo "Docker containers started successfully."
