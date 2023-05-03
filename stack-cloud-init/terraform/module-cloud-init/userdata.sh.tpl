#!/bin/bash
yum update -y
amazon-linux-extras install -y php7.2
yum install -y httpd
sed -i 's/Listen 80/Listen ${target}:${targetport}/g' /etc/httpd/conf/httpd.conf
systemctl start httpd
systemctl enable httpd
usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www
find /var/www -type d -exec chmod 2775 {} \;
find /var/www -type f -exec chmod 0664 {} \;
echo "<h2>Organization</h2>${organisation}<h2>Project</h2>${project}<h2>Environement</h2>${env}<h4>App service name</h4>${app_service_name}<h4>Target</h4>http://${target}:${targetport}<h4>Teleport server</h4>https://${teleportserver}:${teleportport}<?php phpinfo(); ?>" > /var/www/html/index.php
yum-config-manager --add-repo https://rpm.releases.teleport.dev/teleport.repo
sudo yum install teleport
echo ${token} >/tmp/token
sudo teleport app start --name=${app_service_name} --token=/tmp/token --uri=http://${target}:${targetport} --auth-server=https://${teleportserver}:${teleportport}
