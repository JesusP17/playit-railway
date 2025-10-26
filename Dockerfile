FROM openjdk:21-jdk-slim

WORKDIR /app

RUN sed -i 's|deb.debian.org|deb.debian.org/debian|g' /etc/apt/sources.list || true && \
    apt-get update -o Acquire::Retries=5 && \
    apt-get install -y wget curl && \
    apt-get clean

# Descarga el servidor
RUN wget -O server.jar "https://www.dropbox.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=cgkdprbw&dl=1"

# Descarga el playit
ADD https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux ./playit
RUN chmod +x ./playit

COPY eula.txt .

EXPOSE 25565

CMD java -Xmx1G -Xms1G -jar server.jar nogui & ./playit
