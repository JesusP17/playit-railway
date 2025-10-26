# Usa Java 21
FROM openjdk:21-jdk-slim

# Crea directorio de trabajo
WORKDIR /app

# Instala wget para descargar archivos
RUN apt-get update && apt-get install -y wget && apt-get clean

# Descarga tu archivo server.jar desde Dropbox
# Usa el link directo (con ?dl=1)
RUN wget -O server.jar "https://www.dropbox.com/scl/fi/lylzn0ttgd756h2kpwaew/server.jar?rlkey=61knswbbpv8mpaq29qmj7d7a2&st=cgkdprbw&dl=1"

# Copia eula.txt (asegúrate que lo tengas en tu repositorio)
COPY eula.txt .

# Descarga el cliente Playit.gg
ADD https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux ./playit
RUN chmod +x ./playit

# Expone el puerto de Minecraft
EXPOSE 25565

# Ejecuta el servidor de Minecraft y Playit juntos
CMD java -Xmx1024M -Xms1024M -jar server.jar nogui & ./playit
