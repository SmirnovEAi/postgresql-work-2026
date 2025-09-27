#!/usr/bin/env bash
set -euo pipefail
docker compose exec -e PSQLRC=/workspace/.psqlrc db psql -U ${POSTGRES_USER:-postgres} -d ${POSTGRES_DB:-app}
