
# Airflow Docker Compose

This project provides Apache Airflow environments using Docker Compose with support for both **Airflow 2.x** and **Airflow 3.x** versions.

- The `docker-compose.yaml` files are based on the content from https://chalchichi.tistory.com/114.
- The original technical reference is https://airflow.apache.org/docs/apache-airflow/stable/howto/docker-compose/index.html.

## 🚀 Available Versions

This repository supports two separate Airflow environments:

### Airflow 2.x (LTS)
- **Directory**: `airflow-2.x/`
- **Default Image**: `apache/airflow:2.10.2`
- **Web UI Port**: `38080` (configurable via `AIRFLOW_WEBSERVER_PORT`)
- **Recommended for**: Production environments requiring stability

### Airflow 3.x (Latest)
- **Directory**: `airflow-3.x/`
- **Default Image**: `apache/airflow:3.0.6`
- **API Server Port**: `48080` (configurable via `AIRFLOW_APISERVER_PORT`)
- **Recommended for**: Development and testing new features

## 📁 Project Structure

```
├── airflow-2.x/              # Airflow 2.x environment
│   ├── docker-compose.yaml   # Docker Compose configuration for 2.x
│   ├── .env                  # Environment variables for 2.x
│   ├── .env.template         # Template for environment variables
│   ├── run-airflow-cluster.sh
│   ├── cleanup-airflow-cluster.sh
│   ├── dags/                 # Airflow DAG files
│   ├── plugins/              # Airflow plugins
│   ├── logs/                 # Log files
│   └── config/               # Configuration files
├── airflow-3.x/              # Airflow 3.x environment
│   ├── docker-compose.yaml   # Docker Compose configuration for 3.x
│   ├── .env                  # Environment variables for 3.x
│   ├── .env.template         # Template for environment variables
│   ├── run-airflow-cluster.sh
│   ├── cleanup-airflow-cluster.sh
│   ├── dags/                 # Airflow DAG files
│   ├── plugins/              # Airflow plugins
│   ├── logs/                 # Log files
│   └── config/               # Configuration files
└── docker-compose.yaml       # Legacy configuration (deprecated)
```

## 🔧 Getting Started

### Prerequisites
- Docker and Docker Compose installed
- At least 4GB of RAM and 2 CPU cores recommended

### Option 1: Run Airflow 2.x

1. Navigate to the Airflow 2.x directory:
   ```bash
   cd airflow-2.x
   ```

2. (Optional) Copy and customize environment variables:
   ```bash
   cp .env.template .env
   # Edit .env file as needed
   ```

3. Start the Airflow cluster:
   ```bash
   ./run-airflow-cluster.sh
   ```
   
   Or manually:
   ```bash
   docker-compose up airflow-init
   docker-compose up -d
   ```

4. Access Airflow Web UI:
   - URL: http://localhost:38080 (or your configured port)
   - Username: `airflow`
   - Password: `airflow`

### Option 2: Run Airflow 3.x

1. Navigate to the Airflow 3.x directory:
   ```bash
   cd airflow-3.x
   ```

2. (Optional) Copy and customize environment variables:
   ```bash
   cp .env.template .env
   # Edit .env file as needed
   ```

3. Start the Airflow cluster:
   ```bash
   ./run-airflow-cluster.sh
   ```

4. Access Airflow API Server:
   - URL: http://localhost:48080 (or your configured port)
   - Username: `airflow`
   - Password: `airflow`

### Option 3: Run Both Versions Simultaneously

You can run both Airflow 2.x and 3.x environments simultaneously on different ports:

1. Start Airflow 2.x (port 38080):
   ```bash
   cd airflow-2.x && ./run-airflow-cluster.sh
   ```

2. Start Airflow 3.x (port 48080):
   ```bash
   cd airflow-3.x && ./run-airflow-cluster.sh
   ```

## 🛠 Configuration

### Environment Variables

Each version has its own `.env` file with version-specific configurations:

#### Common Variables (both versions):
- `AIRFLOW_UID`: User ID for Airflow containers (default: 50000)
- `AIRFLOW_PROJ_DIR`: Base directory for volume mounts (default: .)
- `_AIRFLOW_WWW_USER_USERNAME`: Admin username (default: airflow)
- `_AIRFLOW_WWW_USER_PASSWORD`: Admin password (default: airflow)
- `_PIP_ADDITIONAL_REQUIREMENTS`: Additional Python packages

#### Version-Specific Variables:

**Airflow 2.x:**
- `AIRFLOW_IMAGE_NAME`: `apache/airflow:2.10.2`
- `AIRFLOW_WEBSERVER_PORT`: Web UI port (default: 8080, example: 38080)

**Airflow 3.x:**
- `AIRFLOW_IMAGE_NAME`: `apache/airflow:3.0.6`
- `AIRFLOW_APISERVER_PORT`: API server port (default: 48080)

### Key Differences Between Versions

| Feature | Airflow 2.x | Airflow 3.x |
|---------|-------------|-------------|
| Authentication | Basic Auth | FabAuthManager |
| Image Version | 2.10.2 | 3.0.6 |
| Default Port | 38080 | 48080 |
| Provider Packages | providers | distributions |
| Stability | Production Ready | Beta/Development |

## 💾 Persistent Data

Both environments use Docker volumes and bind mounts to persist data:

### Docker Named Volumes:
- **postgres-db-volume**: PostgreSQL database files

### Bind Mounts (Host ↔ Container):
- `dags/` ↔ `/opt/airflow/dags` (DAG files)
- `logs/` ↔ `/opt/airflow/logs` (Log files)
- `plugins/` ↔ `/opt/airflow/plugins` (Plugin files)
- `config/` ↔ `/opt/airflow/config` (Configuration files)

## 🧹 Cleanup

To stop and clean up the environment:

```bash
# For Airflow 2.x
cd airflow-2.x && ./cleanup-airflow-cluster.sh

# For Airflow 3.x
cd airflow-3.x && ./cleanup-airflow-cluster.sh
```

Or manually:
```bash
docker-compose down -v
docker volume prune
```

## 📚 Additional Information

### Creating Additional Admin Users

After starting the cluster, you can create additional admin users:

```bash
# Access the webserver container
docker-compose exec airflow-webserver /bin/bash

# Create a new admin user
airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin
```

### Useful Commands

```bash
# Check running containers
docker-compose ps

# View logs
docker-compose logs airflow-webserver
docker-compose logs airflow-scheduler

# Access container shell
docker-compose exec airflow-webserver /bin/bash

# List Docker volumes
docker volume ls
```

## 🤝 Contributing

Feel free to suggest improvements or ask questions by opening an issue or pull request.

---

**Note**: The root-level `docker-compose.yaml` file is deprecated and maintained for backward compatibility. Please use the version-specific directories for new deployments.
