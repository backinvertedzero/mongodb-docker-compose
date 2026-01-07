# mongodb-docker-compose
mongodb docker compose для локального использования. Не для продакшена

# Pre run
docker network create mongodb_network
# Run
docker compose -f ./docker-compose-local.yml -p mongodb-local up -d
# Init
docker compose -f ./docker-compose-local-init.yml -p mongodb-local up

# Use
mongosh -port 27017 -authenticationDatabase "admin" -u "root" -p

mongosh "mongodb://appuser:appuser@localhost:27017/myappdb"