# Imagen base con Java 17
FROM openjdk:17-jdk-slim

# Crea el directorio de trabajo
WORKDIR /app

# Descarga tu server.jar desde Dropbox
RUN apt-get update && apt-get install -y wget && \
    wget -O server.jar "https://www.dropbox.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=3u8q1n2u&dl=1"

# Expón el puerto del servidor
EXPOSE 16378

# Comando para ejecutar el servidor
CMD ["java", "-Xmx1G", "-Xms1G", "-jar", "server.jar", "nogui"]
