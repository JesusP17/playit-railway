FROM openjdk:21-jdk-slim

WORKDIR /app

# Instala wget
RUN apt-get update && apt-get install -y wget && rm -rf /var/lib/apt/lists/*

# Descarga automáticamente Paper 1.21.1 (build 130 por ejemplo)
RUN wget -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.21.1/builds/130/downloads/paper-1.21.1-130.jar

# Acepta el EULA
RUN echo "eula=true" > eula.txt

# Descarga Playit
RUN wget -O playit https://playit.gg/downloads/playit-linux-amd64
RUN chmod +x playit

# Usa variable de entorno para el token Playit (sin archivo local)
ENV PLAYIT_AUTH=""

# Ejecuta playit y el servidor
CMD ./playit --secret "$PLAYIT_AUTH" & java -Xms1G -Xmx2G -jar server.jar --nogui
