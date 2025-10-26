FROM openjdk:21-jdk-slim

WORKDIR /app

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Descargar server.jar correctamente desde Dropbox (forzando nombre y sin redirecciones)
RUN curl -L "https://dl.dropboxusercontent.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=cgkdprbw" -o server.jar

# Aceptar automáticamente la EULA de Minecraft
RUN echo "eula=true" > eula.txt

# Descargar playit.gg
RUN curl -L -o playit https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64 && chmod +x playit

# Crear script que lanza playit y el servidor
RUN echo '#!/bin/bash\n\
set -e\n\
echo "Iniciando Playit..."\n\
./playit &\n\
sleep 10\n\
echo "Iniciando servidor de Minecraft..."\n\
java -Xmx1G -Xms1G -jar /app/server.jar --nogui' > start.sh && chmod +x start.sh

CMD ["./start.sh"]
# Variable de entorno para el token de Playit
ENV PLAYIT_AUTH=${PLAYIT_AUTH}

# Ejecutar Playit y luego el servidor de Minecraft
CMD ./playit & java -Xms1G -Xmx1G -jar server.jar --nogui
