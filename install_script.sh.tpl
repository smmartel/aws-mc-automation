#!/bin/bash
# Direct all output to a log file for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting user_data setup..."

# 1. Ensure the agent is installed and enabled
# Sometimes dnf locks during boot, we use a simple loop to wait for it
until dnf install -y amazon-ssm-agent; do
    echo "Waiting for dnf to be available..."
    sleep 5
done

systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# 2. Update and install dependencies
dnf update -y
dnf install -y java-21-amazon-corretto-headless wget screen

# 3. Setup
mkdir -p /opt/minecraft/server
cd /opt/minecraft/server

# 4. Download 
wget -O minecraft_server.jar "${minecraft_server_jar_url}"

# 5. Accept EULA
echo "eula=true" > eula.txt

# 6. Start the server
screen -dmS minecraft java -Xmx1536M -Xms1536M -jar minecraft_server.jar nogui

# 7. Final nudge: ensure the agent is connected
systemctl restart amazon-ssm-agent
echo "User_data complete."