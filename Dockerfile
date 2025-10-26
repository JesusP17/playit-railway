# Imagen base con Java 21
FROM openjdk:21-jdk-slim

# Crea el directorio de trabajo
WORKDIR /app

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y wget unzip curl && rm -rf /var/lib/apt/lists/*

# Descarga tu server.jar desde Dropbox
RUN wget -O server.jar "https://dl.dropboxusercontent.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=cgkdprbw"

# Copia el archivo eula.txt al contenedor
COPY eula.txt .

# === Instala el agente de Playit ===
RUN wget -O playit "https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64" && \
    chmod +x playit

# Expón el puerto del servidor
EXPOSE 25565

# Ejecuta Playit + Minecraft
CMD ./playit --secret "$PLAYIT_AUTH" & \
    java -Xmx1G -Xms1G -jar server.jar nogui
