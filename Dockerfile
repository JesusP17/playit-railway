# Imagen base con Java 17
FROM openjdk:17-jdk-slim

# Crea un directorio de trabajo
WORKDIR /app

# Descarga tu servidor desde Google Drive (enlace directo)
RUN apt-get update && apt-get install -y wget && \
    wget -O server.jar "https://drive.google.com/uc?export=download&id=1rWoXS-HnkokwOjLZhiJWnQCt_n5L7Ajc"

# Expone el puerto del servidor (ajusta si tu server usa otro)
EXPOSE 25565

# Comando para iniciar el servidor
CMD ["java", "-Xmx1G", "-Xms1G", "-jar", "server.jar", "nogui"]
