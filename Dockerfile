ARG MONGODB_IMAGE_VERSION=8.2.3-noble
FROM mongo:${MONGODB_IMAGE_VERSION}

RUN apt-get update && apt-get install -y \
    curl \
    nano \
    net-tools \
    && rm -rf /var/lib/apt/lists/*

# Копируем конфигурационные файлы
COPY mongod.conf /etc/mongod.conf
