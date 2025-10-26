FROM openjdk:21-jdk-slim

WORKDIR /app

RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Descargar PaperMC (versión 1.21.1 build 130)
RUN curl -L -o server.jar https://api.papermc.io/v2/projects/paper/versions/1.21.1/builds/130/downloads/paper-1.21.1-130.jar

RUN echo "eula=true" > eula.txt

# Descargar Playit correctamente
RUN curl -L -o playit https://playit.gg/downloads/playit-linux-amd64 && chmod +x playit

ENV PLAYIT_AUTH=""

CMD ./playit --secret "$PLAYIT_AUTH" & java -Xms1G -Xmx2G -jar server.jar --nogui
