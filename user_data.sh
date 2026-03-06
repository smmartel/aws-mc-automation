#!/bin/bash

sleep 30 # Wait for the instance to initialize and have network connectivity

# Update the system and install Java 21 (Amazon Corretto)
dnf update -y
dnf install -y java-21-amazon-corretto-headless wget screen

sleep 30 # Wait for the package installation to complete and ensure Java is available

# Create a directory for the Minecraft server and navigate to it
mkdir -p /opt/minecraft/server
cd /opt/minecraft/server

# Download the Minecraft server JAR file
wget https://piston-data.mojang.com/v1/objects/1b9c8e5a0f2c3e5b8d9e7a4c8b6e5f1a2b3c4d/server.jar -O minecraft_server.jar

# Accept the EULA by creating a file named eula.txt with the content "eula=true"
echo "eula=true" > eula.txt

# Start the Minecraft server in a detached screen session
screen -dmS minecraft java -Xmx1536M -Xms1536M -jar minecraft_server.jar nogui

