# 0) Установка PostgreSQL в контейнере

---

## 0) Предварительная подготовка
- (Windows) [Установите WSL2](wsl.md), репозиторий храните в Linux‑файловой системе WSL (`\\wsl$\Ubuntu\home\<имя_пользователя>\...`)
- [Установите Docker Engine](docker.md)

---

## 1) Клонирование репозиторий курсовой работы
1. Клонируйте репозиторий `postgresql-dba-2025-группа` (примечание: для аутентификации может потребоваться [сгенерировать токен доступа](https://github.com/settings/tokens/new), чтобы использовать его вместо пароля)
2. Откройте **терминал в корне репозитория** (там, где `docker-compose.yml`)
3. Изучите содержимое файлов репозитория:
    - `.env` -- файл, в котором задаются значения переменных окружения, используемые для конфигурирования
    - `docker-compose.yml` -- файл, определяющий конфигурацию двух сервисов: `db` (СУБД PostgreSQL) и `pgadmin` (клиент pgAdmin 4)
    - `config/` -- каталог, содержащий конфигурацию сервера PostgreSQL (`postgresql.conf`, `pg_hba.conf`), он монтируется в контейнер
    - `scripts/` -- каталог, содержащий скрипт для удобного подключения к PostgreSQL в контейнере
    - `pgadmin/` -- каталог, содержащий конфигурационный файл для pgAdmin, который автоматически добавлет в него подключение к серверу

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

В репозитории предусмотрен вспомогательный скрипт psql.sh для запуска утилиты psql с заранее заданными параметрами подключения к серверу PostgreSQL внутри контейнера. Перед первым использованием скрипта необходимо сделать его исполняемым, выполнив из корня проекта

```bash
chmod +x ./scripts/psql.sh
```

После этого можно использовать скрипт для подключения к СУБД:

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
docker compose exec -u postgres db psql -U postgres -d app
```

В случае необходимости в этой команде можно изменить имя пользователя (в примере -- `postgres` 2 раза), имя сервиса, куда происходит подключение (в примере -- `db`), имя базы данных (в примере -- `app`).

### 3.2 Через pgAdmin/DBeaver/Datagrip

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

- Перезапустить:

```bash
docker compose restart
```

- Сбросить (удалит данные и бэкапы):

```bash
# Будьте осторожны: удаляет тома!
docker compose down -v
rm -rf archived_wal/* backups/*
```

- Все предыдущие команды работают со всеми сервисами (и `db`, и `pgadmin`), перечисленными в `docker-compose.yml`. Есть возможность управлять только одном сервисом, не трогая другой:

```bash
docker compose restart db   # перезапуск сервера PostgreSQL
docker compose down pgadmin # остановка pgAdmin
```

---

## 5) Просмотр логов

```bash
docker compose logs db      # логи сервера PostgreSQL
docker compose logs pgadmin # логи pgAdmin
```
---

# Содержимое пояснительной записки
1. Снимок экрана `docker compose ps`.
2. Снимок экрана/вставка из psql: `SELECT version();` и `\conninfo`.
3. Результат `SHOW data_directory;` -- подтверждение живого кластера.
4. Снимок экрана pgAdmin/DBeaver/Datagrip с подключением к СУБД.
