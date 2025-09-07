# Repository Guidelines

## Project Structure & Module Organization
- Root data: `dcim_evaluacion_template.csv` and `Plantilla_de_evaluaci_n_DCIM.csv` are the evaluation templates used for DCIM work. Keep headers stable and document changes in the README.
- Docs: `README_DCIM_EVALUACION.md` explains the evaluation context and template usage.
- Dev stack: `workspace/opendcim-stack/` contains a Docker Compose stack for local OpenDCIM:
  - `docker-compose.yaml` defines `db` (MariaDB), `opendcim` (PHP/Apache), and optional `phpmyadmin`.
  - `opendcim/Dockerfile` builds the web image. Default ports: `8080` (OpenDCIM), `8081` (phpMyAdmin).
  - Persistent volumes: `dcim-db`, `dcim-html`.

## Build, Test, and Development Commands
- Run stack (from `workspace/opendcim-stack/`):
  - `docker compose build` — build the web image.
  - `docker compose up -d` — start db/web (and phpMyAdmin) in background.
  - `docker compose logs -f dcim-web` — follow web logs; `docker compose ps` to see health.
  - `docker compose exec dcim-web bash` — shell into the web container.
  - `docker compose down -v` — stop and remove containers and volumes (destroys data).
- Verify locally:
  - Open `http://localhost:8080/install.php` to complete OpenDCIM setup.
  - Optional DB UI: `http://localhost:8081/` (phpMyAdmin).

## Coding Style & Naming Conventions
- YAML: 2-space indent; lowercase service/keys; quote strings with spaces; env vars UPPER_SNAKE_CASE.
- Dockerfile: keep layers minimal, pin versions (e.g., `OPENDCIM_VERSION`), and add concise comments.
- Filenames: ASCII, lowercase, underscores (e.g., `dcim_evaluacion_template.csv`). Keep CSV headers consistent.

## Testing Guidelines
- No automated tests yet. Perform manual smoke tests:
  - `db` and `dcim-web` show healthy status; web UI loads on `:8080`.
  - OpenDCIM connects to MariaDB with compose-provided credentials.
  - CSV templates open cleanly; columns match README expectations.

## Commit & Pull Request Guidelines
- Commits: imperative, concise; prefer Conventional Commits (e.g., `feat(stack): add phpMyAdmin service`).
- PRs: clear description, steps to reproduce/verify locally, affected files, config changes, and any security notes.

## Security & Configuration Tips
- Change default passwords (`MYSQL_ROOT_PASSWORD`, `MYSQL_PASSWORD`) and use a `.env` file for secrets.
- Avoid committing credentials or real production data; sanitize samples.
- Volumes persist data; use `down -v` cautiously.

