# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a DCIM (Data Center Infrastructure Management) evaluation project focused on comparing different DCIM solutions, particularly Sunbird DCIM vs Schneider EcoStruxure IT. The repository contains evaluation templates and a containerized OpenDCIM stack for testing purposes.

## Development Stack Commands

Navigate to `workspace/opendcim-stack/` for all Docker operations:

### Building and Running
- `docker compose build` — Build the OpenDCIM web image
- `docker compose up -d` — Start database, web server, and phpMyAdmin in background
- `docker compose ps` — Check container status and health
- `docker compose logs -f dcim-web` — Follow web container logs
- `docker compose logs -f db` — Follow database logs

### Development and Debugging
- `docker compose exec dcim-web bash` — Shell into web container for debugging
- `docker compose exec db mysql -u dcim -p dcim` — Connect to database (password: dcim)

### Cleanup
- `docker compose down` — Stop containers (preserves data volumes)
- `docker compose down -v` — Stop containers and remove volumes (destroys all data)

### Access Points
- OpenDCIM web interface: `http://localhost:8080/install.php` (initial setup)
- OpenDCIM main interface: `http://localhost:8080/` (after setup)
- phpMyAdmin: `http://localhost:8081/` (credentials from .env file)

### Environment Configuration
Copy and customize the `.env` file in `workspace/opendcim-stack/`:
- Database passwords and credentials
- Port mappings (OPENDCIM_PORT, PHPMYADMIN_PORT)
- PHP configuration limits
- Container and volume names

## Architecture

### Core Components
- **MariaDB 10.11**: Database backend with health checks
- **PHP 8.2 + Apache**: Web server running OpenDCIM 23.04
- **phpMyAdmin**: Optional database management interface

### Data Structure
- `dcim_evaluacion_template.csv` / `Plantilla_de_evaluaci_n_DCIM.csv`: Evaluation templates with scoring criteria (0-5 scale)
- Persistent volumes: `dcim-db` (database), `dcim-html` (web files and uploads)

### Configuration
- Environment variables defined in `.env` file
- Secure database credentials (no hardcoded passwords)
- Configurable ports and PHP limits
- OpenDCIM version controlled via OPENDCIM_VERSION

## File Organization
- Root: CSV evaluation templates and documentation
- `workspace/opendcim-stack/`: Docker Compose stack
- `workspace/opendcim-stack/opendcim/`: Custom Dockerfile with PHP extensions

## Testing and Verification
Manual verification steps:
1. Containers show healthy status: `docker compose ps`
2. Web UI loads at `:8080` without errors
3. Database connection works during OpenDCIM setup
4. CSV templates open cleanly with expected column structure

## Security Notes
- All passwords are configured via `.env` file (not committed to git)
- Default `.env` includes secure passwords - customize for your environment
- Never commit `.env` file or real production credentials
- Avoid committing real production data in CSV templates