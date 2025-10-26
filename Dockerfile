FROM openjdk:21-jdk-slim

WORKDIR /app

# Instalar curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Descargar el servidor desde tu Dropbox
RUN curl -L -o server.jar "https://dl.dropboxusercontent.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=cgkdprbw"

# Aceptar EULA automáticamente
RUN echo "eula=true" > eula.txt

# Descargar Playit y darle permisos de ejecución
RUN curl -L -o playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64
RUN chmod +x playit

# Variable de entorno para el token de Playit
ENV PLAYIT_AUTH=${PLAYIT_AUTH}

# Ejecutar Playit y luego el servidor de Minecraft
CMD ./playit & java -Xms1G -Xmx1G -jar server.jar --nogui
