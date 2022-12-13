#!/bin/bash
sudo apt-get update
sudo apt-get install git nodejs npm -y
cd /tmp
git clone ${git_app_url} webapp
cd webapp
sed -i 's/"homepage": ".*"/"homepage": "."/g' package.json
sudo npm install
sudo npm run build
sudo mkdir /var/www/
sudo mv build/ /var/www/
sudo apt-get install nginx -y
sudo cat << EOF >/etc/nginx/sites-enabled/default
server {
    listen 0.0.0.0:80;
    server_name _;
    access_log /var/log/nginx/app.log;
    root /var/www/build;
    index index.html index.htm;
}
EOF
sudo service nginx stop
sudo service nginx start