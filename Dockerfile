FROM openjdk:21-jdk-slim

WORKDIR /app

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Descargar PaperMC (última build estable de 1.21.1)
RUN curl -L -o server.jar https://api.papermc.io/v2/projects/paper/versions/1.21.1/builds/130/downloads/paper-1.21.1-130.jar

# Aceptar EULA automáticamente
RUN echo "eula=true" > eula.txt

# Descargar Playit
RUN curl -L -o playit https://playit.gg/downloads/playit-linux-amd64 && chmod +x playit

# Variable de entorno del token Playit (la configurás en Railway)
ENV PLAYIT_AUTH=""

# Ejecutar Playit + servidor Paper
CMD ./playit --secret "$PLAYIT_AUTH" & java -Xms1G -Xmx2G -jar server.jar --nogui
