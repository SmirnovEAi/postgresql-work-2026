# Установка Docker в Ubuntu и WLS2 в Windows

---

## 0. Зайти в терминал (в случае Windows -- WSL2)

## 1. Добавить GPG-ключ Docker и обновить список пакетов 

Сначала обновляем индекс пакетов и ставим необходимые утилиты. Затем создаём каталог для ключей и скачиваем официальный ключ Docker.

```bash
# Обновление списка пакетов и установка утилит
sudo apt-get update
sudo apt-get install ca-certificates curl

# Создаём каталог для ключей
sudo install -m 0755 -d /etc/apt/keyrings

# Скачиваем и сохраняем GPG-ключ Docker
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Делаем ключ доступным для чтения
sudo chmod a+r /etc/apt/keyrings/docker.asc
```
## 2. Добавить репозиторий Docker в источники APT

Эта команда подключает официальный репозиторий Docker для вашей версии.

```bash
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Обновляем индекс пакетов
sudo apt-get update
```

## 3. Установить Docker Engine и плагины

Ставим сам Docker Engine, клиент и плагины для Compose и Buildx.

```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

## 4. Проверить работу службы Docker

```bash
sudo systemctl status docker

```

Если служба работает, вы увидите статус active (running).

## 5. Добавить пользователя в группу docker (чтобы не писать sudo при работе с Docker)

Создаём группу `docker` (если её нет), если группа уже есть -- будет ошибка, игнорируем ее.

```bash
sudo groupadd docker
```

Добавляем в группу `docker` текущего пользователя

```bash
sudo usermod -aG docker $USER
```

После этого выйдите из системы и войдите снова (или выполните `newgrp docker`), чтобы изменения вступили в силу.

## 6. Проверить установку

Запускаем тестовый контейнер:
```bash
docker run hello-world
```

Если всё настроено правильно, вы увидите приветственное сообщение от Docker.


# Установка Docker в macOS

---

## 0. Зайти в терминал

## 1. Установить менеджер пакетов Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## 2. Установить с помощью Homebrew Docker Engine и менеджер виртуальных машин Colima

```bash
brew install docker docker-compose colima
```

## 3. Запустить Colima

Colima создаёт легковесную виртуальную машину с Linux и Docker Engine внутри:

```bash
colima start
```

## 4. Проверить установку

Запускаем тестовый контейнер:

```bash
docker run hello-world
```

Если всё настроено правильно, вы увидите приветственное сообщение от Docker.