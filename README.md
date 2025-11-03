# Курсовая работа "Администрирование PostgreSQL"

**Цель курсовой работы** -- освоение основных принципов администрирования системы управления базами данных PostgreSQL, получение практических навыков установки и настройки сервера, управления базами данных и пользователями, организации хранения и резервного копирования данных, а также настройки физической и логической репликации в контейнерной среде Docker.

### Предварительная информация

[Отличия курсовой работы от курса DBA1](docs/meta.md)

[Рекомендуемый ход выполнения](docs/workflow.md)

[Оформление отчета](docs/report.md)

[Оценивание выполнения курсовой работы](docs/grades.md)

0. [Установка PostgreSQL в контейнере](docs/setup.md)
### Базовый инструментарий
1. Управление сервером | [теория](docs/theory/1-server-management.md) | [практика](docs/practice/1-server-management.md)
2. Использование psql | [теория](docs/theory/2-psql.md) | [практика](docs/practice/2-psql.md)
3. Конфигурирование сервера | [теория](docs/theory/3-configuration.md) | [практика](docs/practice/3-configuration.md)
### Архитектура
4. Общее устройство PostgreSQL | [теория](docs/theory/4-architecture.md)
5. Изоляция и многоверсионность | [теория](docs/theory/5-mvcc.md)
6. Очистка | [теория](docs/theory/6-vacuum.md) | [практика](docs/practice/6-vacuum.md)
7. Буферный кеш и журнал | [теория](docs/theory/7-wal.md)
### Организация данных
8. Базы данных и схемы | [теория](docs/theory/8-databases.md) | [практика](docs/practice/8-databases.md)
9. Системный каталог | [теория](docs/theory/9-catalog.md) | [практика](docs/practice/9-catalog.md)
10. Табличные пространства | [теория](docs/theory/10-tablespaces.md) | [практика](docs/practice/10-tablespaces.md)
11. Низкий уровень | [теория](docs/theory/11-lowlevel.md) | [практика](docs/practice/11-lowlevel.md)
### Администрирование
12. Мониторинг | [теория](docs/theory/12-monitoring.md) | [практика](docs/practice/12-monitoring.md)
13. Управление доступом | [теория](docs/theory/13-access.md) | [практика](docs/practice/13-access.md)
14. Резервное копирование | [теория](docs/theory/14-backup.md) | [практика](docs/practice/14-backup.md)
15. Физическая репликация | [теория](docs/theory/15-physical-replication.md) | [практика](docs/practice/15-physical-replication.md)
16. Логическая репликация | [теория](docs/theory/16-logical-replication.md)