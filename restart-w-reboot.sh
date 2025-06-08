[Unit]
    Description=Minecraft Server
    After=network.target

    [Service]
    WorkingDirectory=/home/ec2-user/minecraft
    ExecStart=/usr/bin/java -Xmx1024M -Xms1024M -jar /home/ec2-user/minecraft/minecraft_server.jar nogui
    Restart=always

    [Install]
    WantedBy=multi-user.target
