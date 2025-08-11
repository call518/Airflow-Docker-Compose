#!/bin/bash

# Airflow 클러스터 중지
docker-compose down

# Airflow PostgreSQL Docker 볼륨 삭제
docker volume rm airflow-docker-compose_postgres-db-volume

PERSIST_DIRS="./config ./dags ./logs ./plugins"
rm -rf ${PERSIST_DIRS}
mkdir -p ${PERSIST_DIRS}
ls -al ${PERSIST_DIRS}