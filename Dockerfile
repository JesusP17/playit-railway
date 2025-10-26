FROM openjdk:21-jdk-slim

WORKDIR /app

# Instalar dependencias básicas
RUN apt-get update -o Acquire::Retries=5 && \
    apt-get install -y wget curl && \
    apt-get clean

# Descargar el server.jar desde Dropbox
RUN wget -O server.jar "https://www.dropbox.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=cgkdprbw&dl=1"

# Copiar el archivo eula.txt (debe estar en tu repo)
COPY eula.txt .

# Exponer el puerto del servidor
EXPOSE 25565

# Comando de ejecución
CMD ["java", "-Xmx1G", "-Xms1G", "-jar", "server.jar", "nogui"]
