# mongodb-docker-compose
mongodb docker compose для локального использования. Не для продакшена

# Pre run
1. docker network create mongodb_network

2. скопировать файл .emv.example в файл .env
# Run
docker compose -f ./docker-compose-local.yml -p mongodb-local up -d
# Init
Для инициализации юзеров, нужно посмотреть файл init-scripts/01-create-app-db.js и поправить необходимые данные

затем выполнить

docker compose -f ./docker-compose-local-init.yml -p mongodb-local up

# Persist
Если необходимо данные где-то сохранять на диске, то нужно что-то сделать с вольюмами, на ваш выбор.


# Use
mongosh -port 27017 -authenticationDatabase "admin" -u "root" -p

mongosh "mongodb://appuser:appuser@localhost:27017/myappdb"
