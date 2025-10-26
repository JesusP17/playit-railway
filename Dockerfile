FROM openjdk:21-jdk-slim

WORKDIR /app

# Copiar archivos necesarios
COPY eula.txt .
COPY playit .
COPY PLAYIT_AUTH .

# Descargar automáticamente PaperMC 1.21.1 si no existe
RUN apt-get update && apt-get install -y curl && \
    if [ ! -f server.jar ]; then \
    echo "Descargando PaperMC 1.21.1..." && \
    curl -o server.jar https://api.papermc.io/v2/projects/paper/versions/1.21.1/builds/130/downloads/paper-1.21.1-130.jar; \
    fi

# Permisos
RUN chmod +x playit

# Ejecutar Playit + Minecraft Server
CMD ./playit --secret "$PLAYIT_AUTH" & \
    sleep 5 && \
    java -Xmx2G -Xms1G -jar server.jar --nogui
