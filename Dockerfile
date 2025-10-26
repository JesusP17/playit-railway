FROM openjdk:21-jdk-slim

WORKDIR /app

# Instalar dependencias
RUN apt-get update && apt-get install -y wget curl unzip && apt-get clean

# Descargar el servidor desde Dropbox
RUN wget -O server.jar "https://www.dropbox.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=cgkdprbw&dl=1"

# Descargar Playit Agent (versión funcional)
RUN wget -O playit https://github.com/playit-cloud/playit-agent/releases/download/v0.16.5/playit-linux && chmod +x playit

# Copiar EULA
COPY eula.txt .

# Exponer el puerto del servidor
EXPOSE 25565

# Ejecutar el servidor de Minecraft y Playit automáticamente
CMD bash -c "java -Xmx1G -Xms1G -jar server.jar nogui & ./playit --secret '25c5cddbd1e75139f0a4e186df6314a6f3fa5c9fc0fb205d25b1e74bb1b7c556'"
