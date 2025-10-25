#!/bin/bash
# Script para iniciar Playit.gg en Railway

echo "Iniciando Playit.gg..."
chmod +x Playit
./Playit --secret_path ./secret

echo "esperando que playit inicie"
sleep 10 

echo "iniciando servidor de minecraft..."
java -Xms1g -jar server.jar nogui 