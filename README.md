# Inception

> A Docker infrastructure project that sets up a complete WordPress environment with multiple services using Docker Compose.

---

## Overview

This project demonstrates a **multi-container Docker application** that deploys a WordPress website with various supporting services. All services run in separate containers following best practices for containerization and orchestration.

---

## Architecture

The infrastructure consists of the following services:

### Core Services

- **NGINX**: Reverse proxy server handling HTTPS traffic on port 443 with TLS 1.2/1.3
- **WordPress**: Content management system running on PHP-FPM
- **MariaDB**: Database server with health checks for WordPress data persistence

### Bonus Services

- **Redis**: Caching layer for WordPress performance optimization
- **Adminer**: Web-based database management interface (port 8081)
- **cAdvisor**: Container monitoring and performance analysis tool (port 8082)
- **FTP Server**: File transfer service with passive mode support (port 21, passive ports 5000-5010)
- **Static Website**: Custom nginx-served website showcasing additional functionality (port 8083)

---

## Project Structure

```text
inception/
├── Makefile
├── README.md
└── srcs/
    ├── .env
    ├── docker-compose.yml
    └── requirements/
        ├── nginx/
        │   ├── Dockerfile
        │   └── conf/nginx.conf
        ├── wordpress/
        │   ├── Dockerfile
        │   └── tools/wordpress_conf.sh
        ├── mariadb/
        │   ├── Dockerfile
        │   └── tools/script-md.sh
        └── bonus/
            ├── adminer/
            ├── cadvisor/
            ├── redis/
            ├── ftp/
            └── website/
```

---

## Features

- **Automated Setup**: Complete infrastructure deployment with a single command
- **SSL/TLS Encryption**: Self-signed certificates for secure HTTPS connections
- **Persistent Storage**: Data volumes for WordPress files and MariaDB database
- **Health Checks**: MariaDB health monitoring ensuring proper service dependencies
- **Redis Caching**: Integrated WordPress caching for improved performance
- **Container Monitoring**: Real-time metrics via cAdvisor
- **Database Management**: Easy database access through Adminer web interface
- **FTP Access**: File management capabilities for WordPress content

---

## Prerequisites

- Docker Engine
- Docker Compose
- Make

---

## Installation

### 1. Clone the repository:

```bash
git clone <repository-url>
cd inception
```

### 2. Configure environment variables in `srcs/.env`:

```env
DOMAIN_NAME=your-domain.42.fr

# MariaDB Configuration
DATA_BASE=your_database
USER=your_user
PASSWORD=your_password
ROOT_PASSWORD=your_root_password

# WordPress Admin
ADMIN_NAME=admin_username
ADMIN_PASSWORD=admin_password
ADMIN_MAIL=admin@example.com

# WordPress Additional User
USER_NAME=username
USER_PASSWORD=user_password
USER_MAIL=user@example.com
USER_ROLE=author
```

### 3. Update the data paths in the Makefile to match your system:

```makefile
WP_DATA_PATH = /home/yourusername/data/wp_data
DB_DATA_PATH = /home/yourusername/data/wp_db_data
```

### 4. Add your domain to `/etc/hosts`:

```bash
echo "127.0.0.1 your-domain.42.fr" | sudo tee -a /etc/hosts
```

---

## Usage

### Build and Start Services

```bash
make
```

This command will:

- Create necessary data directories
- Build all Docker images
- Start all containers in detached mode

### Access Services

- **WordPress**: [https://your-domain.42.fr](https://your-domain.42.fr)
- **Adminer**: [http://localhost:8081](http://localhost:8081)
- **cAdvisor**: [http://localhost:8082](http://localhost:8082)
- **Static Website**: [http://localhost:8083](http://localhost:8083)
- **FTP**: ftp://localhost:21 (user: `user_ftp`, password: `pw_ftp`)

---

## Available Make Commands

### Container Management

```bash
make re          # Rebuild everything from scratch
make fclean      # Stop containers and remove all data
make freshbuild  # Clean build without cache
```

### Shell Access

```bash
make ngshell     # Access NGINX container
make wpshell     # Access WordPress container
make mdbshell    # Access MariaDB container
make siteshell   # Access static website container
make cvshell     # Access cAdvisor container
make adshell     # Access Adminer container
make rcshell     # Access Redis container
make ftpshell    # Access FTP container
```

### View Logs

```bash
make nglogs      # NGINX logs
make wplogs      # WordPress logs
make mdlogs      # MariaDB logs
make sitelogs    # Static website logs
make cvlogs      # cAdvisor logs
make adlogs      # Adminer logs
make rclogs      # Redis logs
make ftplogs     # FTP logs
```

---

## Technical Details

### Networking

All services communicate through a custom bridge network named `inception`, ensuring isolation and secure inter-container communication.

### Volumes

Two persistent volumes are configured:

- `wp_data`: WordPress files mounted at `/var/www/wordpress`
- `wp_db_data`: MariaDB database files mounted at `/var/lib/mysql`

### Security

- NGINX configured with TLS 1.2 and 1.3 protocols
- Self-signed SSL certificates for HTTPS
- Database access restricted to internal network
- FTP server with chroot jail for user isolation

### WordPress Configuration

The WordPress setup includes:

- Automatic core installation via WP-CLI
- Database configuration
- Admin user creation
- Additional user creation with customizable role
- Redis cache plugin installation and activation

---

## Cleanup

To completely remove the infrastructure and all data:

```bash
make fclean
```

> **Warning:** This will delete all WordPress content and database data permanently.

---

> **Note:** This setup uses self-signed certificates for development purposes. For production environments, use certificates from a trusted Certificate Authority.