# Отличия курсовой работы от курса DBA1

Средой выполнения в курсе DBA1 выступает виртуальная машина с Ubuntu, тогда как курсовая работа построена в контейнерной среде, используются официальные Docker-образы PostgreSQL. При этом создаются два изолированные сервиса: `db` и `db_replica`, в которые монтируются пути из репозитория:

```yaml
pg_primary_data:/var/lib/postgresql/data
./config/postgresql.conf:/etc/postgresql/postgresql.c
./config/pg_hba.conf:/etc/postgresql/pg_hba.conf:ro
./init:/docker-entrypoint-initdb.d:ro
./archived_wal:/archived_wal
./backups:/backups
./tablespaces:/tablespaces
./.psqlrc:/var/lib/postgresql/.psqlrc:ro
```

В этом перечне в каждой строке то, что идет до двоеточия, -- каталог или файл, лежащий в репозитории, а после двоеточия -- путь в файловой системе контейнера сервиса `db`.

В курсе DBA1 используется пользователь `student` с root-доступом, тогда как внутри контейнеров используется пользователь `postgres`.

В курсе DBA1 для управления кластером используется утилита `pg_ctlcluster`:

```bash
sudo pg_ctlcluster 16 main start
sudo pg_ctlcluster 16 main stop
```

а для проверки состояния кластера используется `systemd`:

```bash
systemctl status postgresql
```

В контейнерах нет ни утилиты `pg_ctlcluster`, ни системы `systemd`. К счастью, можно запускать или останавливать сервер с помощью остановки/запуска сервиса:

```bash
docker compose start db
docker compose stop db
```

Для управления кластером изнутри запущенного контейнера используется:

```bash
pg_ctl -D /var/lib/postgresql/data -o "-c config_file=/etc/postgresql/postgresql.conf" -w start
pg_ctl -D /var/lib/postgresql/data -m fast stop
pg_ctl -D /var/lib/postgresql/data status
```

В курсе DBA1 для инициализации кластера используется 

```bash
initdb -D /var/lib/postgresql/16/main
```

В курсовой работе инициализация происходит автоматически при первом запуске контейнера.

Команды в оболочке bash, приведенные в курсе DBA1, выполняются непосредственно в командной строке, например, 

```bash
pg_basebackup -h localhost -U replicator -D /home/student/tmp/backup
```

В курсовой работе для того чтобы команда имела доступ к файловой системе контейнера, необходимо либо предварительно заходить в bash контейнера:

```bash
docker compose exec -u postgres db bash
```

после чего выполнять команду, либо делать это сразу же в хостовой ОС, например:

```bash
docker compose exec db_replica pg_basebackup -h db -U replicator -D /var/lib/postgresql/data
```
