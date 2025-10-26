FROM openjdk:21-jdk-slim

WORKDIR /app

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y wget curl unzip && rm -rf /var/lib/apt/lists/*

# Descargar automáticamente la última versión estable de Paper 1.21.1
RUN wget -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.21.1/builds/120/downloads/paper-1.21.1-120.jar

# Copiar eula.txt (aceptar términos)
COPY eula.txt .

# Instalar y preparar el cliente de Playit
RUN wget -O playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64
RUN chmod +x playit

# Exponer el puerto del servidor
EXPOSE 25565

# Ejecutar Playit + Minecraft Paper
CMD ./playit --secret "$PLAYIT_AUTH" & \
    sleep 5 && \
    ls -l && \
    java -Xmx1G -Xms1G -jar /app/server.jar nogui
