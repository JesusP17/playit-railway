FROM openjdk:21-jdk-slim

WORKDIR /app

# Instalar curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Descargar el servidor desde Dropbox
RUN curl -L "https://dl.dropboxusercontent.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=ldqdg2f5" -o server.jar

# Aceptar EULA y configurar servidor
RUN echo "eula=true" > eula.txt && \
    echo "online-mode=false" > server.properties && \
    echo "motd=Servidor Playit en Railway (Paper/Purpur 1.18.2)" >> server.properties && \
    echo "view-distance=6" >> server.properties && \
    echo "max-tick-time=60000" >> server.properties && \
    echo "max-players=10" >> server.properties

# Descargar el cliente de Playit.gg
RUN curl -L -o playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 && chmod +x playit

# Variable de entorno para el token de Playit
ENV PLAYIT_AUTH=${PLAYIT_AUTH}

# Crear el script de inicio dentro de /app
RUN echo '#!/bin/bash' > /app/start.sh && \
    echo 'set -e' >> /app/start.sh && \
    echo 'cd /app' >> /app/start.sh && \
    echo 'echo "Iniciando Playit..."' >> /app/start.sh && \
    echo './playit --secret $PLAYIT_AUTH &' >> /app/start.sh && \
    echo 'sleep 10' >> /app/start.sh && \
    echo 'echo "Iniciando servidor 1.18.2..."' >> /app/start.sh && \
    echo 'java -Xmx512M -Xms256M -jar /app/server.jar --nogui' >> /app/start.sh && \
    chmod +x /app/start.sh

# Comando final
CMD ["bash", "/app/start.sh"]
