# Imagen base con Java 17
FROM openjdk:21-jdk-slim

# Crea el directorio de trabajo
WORKDIR /app

# Instala wget y descarga tu server.jar desde Dropbox
RUN apt-get update && apt-get install -y wget && \
    wget -O server.jar "https://www.dropbox.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&dl=1"

COPY eula.txt.    

# Expón el puerto del servidor
EXPOSE 16378

# Comando para ejecutar el servidor
CMD ["java", "-Xmx1G", "-Xms1G", "-jar", "server.jar", "nogui"]
