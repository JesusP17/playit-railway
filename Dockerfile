# Imagen base con Java 21
FROM openjdk:21-jdk-slim

# Crea el directorio de trabajo
WORKDIR /app

# Instala dependencias necesarias y descarga tu server.jar desde Dropbox
RUN apt-get update && apt-get install -y wget curl unzip && \
    wget -O server.jar "https://dl.dropboxusercontent.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=cgkdprbw" && \
    apt-get clean

# Copia el archivo eula.txt al contenedor
COPY eula.txt .

# Expón el puerto del servidor Minecraft
EXPOSE 25565

# === PLAYIT ===
# Descarga el agente de Playit
RUN wget -O playit.zip "https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux.zip" && \
    unzip playit.zip && \
    chmod +x playit && \
    rm playit.zip

# Variable de entorno para el TOKEN de Playit
ENV PLAYIT_AUTH=""

# Inicia Playit y luego el servidor de Minecraft
CMD ./playit --secret "$PLAYIT_AUTH" & java -Xmx1G -Xms1G -jar server.jar nogui
