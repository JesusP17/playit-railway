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

# Variable de entorno para el token de Playit (la define Railway)
ENV PLAYIT_AUTH=${PLAYIT_AUTH}

# Crear script de inicio
RUN echo '#!/bin/bash\n\
set -e\n\
echo "Iniciando Playit..."\n\
./playit --secret $PLAYIT_AUTH &\n\
sleep 10\n\
echo "Iniciando servidor de Minecraft..."\n\
java -Xmx1G -Xms1G -jar /app/server.jar --nogui' > start.sh && chmod +x start.sh

# Comando final que ejecuta el script
CMD ["bash", "./start.sh"]
