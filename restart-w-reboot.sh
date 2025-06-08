#!/bin/bash

# Install Java
sudo amazon-linux-extras enable corretto11
sudo yum clean metadata
sudo yum install -y java-11-amazon-corretto

# Make sure the Minecraft directory exists
mkdir -p /home/ec2-user/minecraft

# Upload the systemd service file
cat <<EOF | sudo tee /etc/systemd/system/minecraft.service
[Unit]
Description=Minecraft Server
After=network.target

[Service]
WorkingDirectory=/home/ec2-user/minecraft
ExecStart=/usr/bin/java -Xmx1024M -Xms1024M -jar /home/ec2-user/minecraft/minecraft_server.jar nogui
Restart=always
User=ec2-user

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd and enable the service
sudo systemctl daemon-reload
sudo systemctl enable minecraft
sudo systemctl start minecraft

