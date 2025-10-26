FROM openjdk:21-jdk-slim

WORKDIR /app

# Instalar curl
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Descargar el servidor desde Dropbox
RUN curl -L "https://dl.dropboxusercontent.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=ldqdg2f5&dl=0" -o server.jar

# Aceptar EULA y configurar servidor
RUN echo "eula=true" > eula.txt && \
    echo "online-mode=false" > server.properties && \
    echo "motd=Servidor Playit en Railway (Purpur 1.18.2 optimizado)" >> server.properties && \
    echo "view-distance=6" >> server.properties && \
    echo "simulation-distance=4" >> server.properties && \
    echo "max-tick-time=60000" >> server.properties && \
    echo "max-players=10" >> server.properties && \
    echo "spawn-limits=monsters=20,animals=5,water=5,ambient=2" >> server.properties && \
    echo "entity-activation-range=6" >> server.properties && \
    echo "use-native-transport=true" >> server.properties

# Descargar el cliente de Playit.gg
RUN curl -L -o playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 && chmod +x playit

# Variable de entorno para el token de Playit
ENV PLAYIT_AUTH=${PLAYIT_AUTH}

# Crear el script de inicio
RUN cat << 'EOF' > /app/start.sh
#!/bin/bash
set -e
cd /app
echo "Iniciando Playit..."
./playit --secret $PLAYIT_AUTH &
sleep 10
echo "Iniciando servidor Purpur 1.18.2..."
java -Xms256M -Xmx512M -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:G1NewSizePercent=20 -XX:G1ReservePercent=20 -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=8M -jar /app/server.jar --nogui
EOF

RUN chmod +x /app/start.sh 

# Comando final
CMD ["bash", "/app/start.sh"]
