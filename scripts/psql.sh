#!/usr/bin/env bash
set -euo pipefail
docker compose exec -u ${POSTGRES_USER:-postgres} db psql -U ${POSTGRES_USER:-postgres} -d ${POSTGRES_DB:-app}