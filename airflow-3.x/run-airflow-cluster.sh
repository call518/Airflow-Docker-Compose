#!/bin/bash
set -euo pipefail

# Airflow 초기화
docker-compose up airflow-init

# 모든 컨테이너 시작
docker-compose up -d

# Airflow 추가 관리자 생성 예시
# docker-compose exec airflow-webserver /bin/bash 로 쉘 접속후, 아래 명령 실행.
# airflow users create \
#     --username admin \
#     --firstname Admin \
#     --lastname User \
#     --role Admin \
#     --email admin@example.com \
#     --password admin
