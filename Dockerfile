# Imagen base con Java 17 (Railway soporta OpenJDK)
FROM openjdk:17-jdk-slim

# Carpeta de trabajo dentro del contenedor
WORKDIR /app

# Descargar el archivo server.jar desde Dropbox
ADD https://www.dropbox.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=3u8q1n2u&dl=1 /app/server.jar

# Exponer el puerto del servidor
EXPOSE 16378

# Comando para arrancar el servidor de Minecraft
CMD ["java", "-Xmx1G", "-Xms1G", "-jar", "server.jar", "nogui"]
