FROM openjdk:21-jdk-slim

WORKDIR /app

# Instalar curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Descargar el servidor desde Dropbox
RUN curl -L "https://dl.dropboxusercontent.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=cgkdprbw" -o server.jar

# Aceptar EULA automáticamente
RUN echo "eula=true" > eula.txt

# Descargar el cliente de Playit.gg
RUN curl -L -o playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 && chmod +x playit

# Variable de entorno para el token de Playit
ENV PLAYIT_AUTH=${PLAYIT_AUTH}

# Crear el script de inicio dentro de /app
RUN bash -c 'echo "#!/bin/bash
set -e
cd /app
echo Iniciando Playit...
./playit --secret \$PLAYIT_AUTH &
sleep 10
echo Iniciando servidor de Minecraft...
java -Xmx1G -Xms1G -jar /app/server.jar --nogui
" > /app/start.sh && chmod +x /app/start.sh'

# Comando final
CMD ["bash", "/app/start.sh"]
