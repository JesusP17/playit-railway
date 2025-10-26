FROM openjdk:21-jdk-slim

WORKDIR /app

RUN apt-get update -o Acquire::Retries=5 && \
    apt-get install -y wget curl && \
    apt-get clean

# Descargar tu servidor desde Dropbox
RUN wget -O server.jar "https://www.dropbox.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=cgkdprbw&dl=1"

# Copiar eula.txt (debe estar en el mismo repo)
COPY eula.txt .

# Exponer el puerto de Minecraft
EXPOSE 25565

# Comando que ejecuta el servidor y luego instala Playit dinámicamente
CMD java -Xmx1G -Xms1G -jar server.jar nogui & \
    wget -O playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux && \
    chmod +x playit && \
    ./playit
