## Настраиваем окружение дома

### Устанавливаем пакеты

#### docker

```bash
sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update && sudo apt install docker-ce
sudo adduser username docker
```
*username* - имя вашего пользователя

#### docker-compose

```bash
sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
### Подготавливаем docker-compose
**docker-compose**, который мы установили в прошлом разделе, нужен для конфигурации и запуска одного или нескольких образов. Умеет очень многое - [можете почитать тут](https://docs.docker.com/compose/).

Конфигурации можно использовать любые, но [вот здесь](https://gitlab.techart.ru/skryabin/dockerhome) будет держатся и поддерживатся, если будет востребована, только сборка с apache и nginx+phpfpm.

Что делаем - клоним к себе проект (он публичный) или просто скачиваем архим, переходим в папочку `apache` или `nginxphpfpm` и запускаем `docker-compose up`. Только в первый раз начнется сборка, которая потом сформирует образ, который будет запускатся быстро. Папочка `workspace` пробросится в контейнер, в ней в public или www - docroot сайта.
Тушим по `ctrl+c`.

Из важных параметров, которые вам, возможно, захочется поменять.

Какой порт пробрасываем в контейнер. По умолчанию оставил 808, можете поменять на 80. Первым идёт порт хост системы - вторым порт в контейнере. В файле `docker-compose.yml`
```bash
ports:
  - "808:80"
```

Какая версия PHP собирается в файлах `apache/docker/apache.docker` или `nginxphpfpm/docker/phpfpm.docker`
```bash
ARG full_name=7.2
ARG short_name=72
```

Смотрите, используется в качестве контейнера ubuntu 18.04 а вот php ставится из ppa:ondrej/php. Сделано это для того, чтобы всегда была возможность использовать поддерживаемые ветки php. Локально php-fpm собирается из сырцов. Хотим версию 7.3 - меняем:
```bash
ARG full_name=7.3
ARG short_name=73
```

Да, наименования не сильно правильные, возможно, но вот ничего другого не придумалось. И запускаем `docker-compose up --build`.

Внутрь каждого контейнера проброшен сокет mysql, поэтому должно всё конектиться к localhost
