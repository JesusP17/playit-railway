# Imagen base con Java 17 (Railway soporta OpenJDK)
FROM openjdk:17-jdk-slim

# Copiar todos los archivos del proyecto al contenedor
WORKDIR /app
COPY . .

# Puerto (opcional, si tu servidor usa uno fijo)
EXPOSE 16378

# Comando para arrancar el servidor
CMD ["java", "-Xmx1G", "-Xms1G", "-jar", "server.jar", "nogui"]
