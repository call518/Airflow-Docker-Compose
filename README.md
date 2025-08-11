
# Airflow Docker Compose

This project provides a simple environment to run Apache Airflow using Docker Compose.

- The `docker-compose.yaml` file is based on the content from https://chalchichi.tistory.com/114.
- The original technical reference is https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html.

## Getting Started

1. Make sure Docker and Docker Compose are installed.
2. Start Airflow with the following command:

```bash
docker-compose up
```

## Folder Structure
- `dags/` : Airflow DAG files
- `plugins/` : Airflow plugins
- `logs/` : Log files


## Persistent Docker Volumes

This setup uses Docker volumes and bind mounts to persist important Airflow data:

- **postgres-db-volume**: Docker named volume for PostgreSQL database files. This ensures your Airflow metadata and state are preserved even if the database container is recreated.
	- Mounted at `/var/lib/postgresql/data` in the `postgres` container.

- **Bind mounts** (host folders mapped to containers):
	- `dags/` → `/opt/airflow/dags` (Airflow DAGs)
	- `logs/` → `/opt/airflow/logs` (Airflow logs)
	- `plugins/` → `/opt/airflow/plugins` (Airflow plugins)
	- `config/` → `/opt/airflow/config` (optional Airflow config)

These folders on your host machine will retain their contents even if you restart or recreate containers.

To list Docker volumes:
```bash
docker volume ls
```

For details, see the `volumes:` section in `docker-compose.yaml`.

---
Feel free to suggest improvements or ask questions.
