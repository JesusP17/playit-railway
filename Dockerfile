# Imagen base con Java 21
FROM openjdk:21-jdk-slim

# Crea el directorio de trabajo
WORKDIR /app

# Instala dependencias necesarias (wget, unzip)
RUN apt-get update && apt-get install -y wget unzip && rm -rf /var/lib/apt/lists/*

# Descarga tu server.jar desde Dropbox
RUN wget -O server.jar "https://dl.dropboxusercontent.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=cgkdprbw"

# Copia el archivo eula.txt al contenedor
COPY eula.txt .

# === INSTALACIÓN DE PLAYIT ===
RUN wget -O playit.zip "https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux.zip" && \
    unzip playit.zip && \
    chmod +x playit && \
    rm playit.zip

# Expón el puerto del servidor de Minecraft
EXPOSE 25565

# Ejecuta Playit con la clave secreta y el servidor de Minecraft
CMD ./playit --secret "$PLAYIT_AUTH" & java -Xmx1G -Xms1G -jar server.jar nogui
