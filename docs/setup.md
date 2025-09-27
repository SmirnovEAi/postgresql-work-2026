# Установка PostgreSQL в контейнере

---

## 0) Предварительная подготовка
- (Windows) Установите WSL2, репозиторий храните в Linux‑файловой системе WSL (`\\wsl$\Ubuntu\home\<имя_пользователя>\...`)
- Установите Docker Engine

---

## 1) Клонирование репозиторий курсовой работы
1. Клонируйте репозиторий postgresql-dba-группа
2. Откройте **терминал в корне репозитория** (там, где `docker-compose.yml`)
3. Изучите содержимое файлов репозитория:
  - .env -- файл, в котором задаются значения переменных окружения, используемые для конфигурирования
  - docker-compose.yml -- файл, определяющий конфигурацию двух сервисов: pg (СУБД PostgreSQL) и pgadmin (клиент pgAdmin 4)
  - config/ -- каталог, содержащий конфигурацию сервера PostgreSQL (postgresql.conf, pg_hba.conf), он монтируется в контейнер
  - scripts/ -- каталог, содержащий скрипт для удобного подключения к PosgreSQL в контейнере
  - pgadmin/ -- каталог, содержащий конфигурационный файл для pgAdmin, который автоматически добавлет в него подключение к серверу

---

## 2) Запуск сервера PostgreSQL

```bash
docker compose up -d
```

Проверьте статус:
```bash
docker compose ps
```
Должен быть контейнер `pg-primary` в состоянии `running`. Сервер по умолчанию слушает порт **5432** (или другой `PRIMARY_PORT` из `.env`).

---

## 3) Проверка подключения

### 3.1 Через psql

Из корня проекта:

```bash
./scripts/psql.sh
```

Внутри psql:

```sql
SELECT version();
\conninfo
```

Выход: `\q`

Если скрипт не работает:

```bash
docker compose exec -e PSQLRC=/workspace/.psqlrc db psql -U postgres -d app
```

### 3.2 Через pgAdmin/DBeaver

- **pgAdmin:** http://localhost:8081  (логин `admin@example.com`, пароль `admin`). Сервер **Local Primary** уже добавлен. Пароль `postgres`.
- **DBeaver/Datagrip:** Host `localhost`, Port `5432`, DB `app`, User `postgres`, Password `postgres`.

---

## 4) Данные и конфиги
- Данные хранятся в docker‑томе `pg_primary_data` (персистентно).
- Конфиги берутся из `config/postgresql.conf` и `config/pg_hba.conf`.
- Проверка путей в psql:
```sql
SHOW data_directory;
SHOW config_file;
SHOW hba_file;
```

---

## 5) Остановка/перезапуск/сброс
- Остановить:
```bash
docker compose down
```
- Сбросить (удалит данные и бэкапы):
```bash
# Будьте осторожны: удаляет тома!
docker compose down -v
rm -rf archived_wal/* backups/*
```

---

## 6) Содержимое пояснительной записки
1. Скрин `docker compose ps`.
2. Скрин/вставка из psql: `SELECT version();` и `\conninfo`.
3. Результат `SHOW data_directory;` — подтверждение живого кластера.
4. (Опционально) Скрин pgAdmin с подключением **Local Primary**.
