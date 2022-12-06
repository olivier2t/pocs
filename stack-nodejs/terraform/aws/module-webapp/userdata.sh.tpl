#!/bin/bash
sudo apt update
sudo apt install git -y
cd $(mktemp -d)
git clone ${git_app_url} webapp
cd webapp
sudo npm install
sudo npm run build
sudo mkdir /var/www/
sudo scp -r ./build/* /var/www/build/
sudo apt install nginx -y
sudo cat << EOF >/etc/nginx/sites-enabled/default
server {
    listen 0.0.0.0:80;
    server_name _;
    access_log /var/log/nginx/app.log;
    root /var/www/build;
    index index.html index.htm;
    try_files $uri /index.html;
    location / {
        try_files $uri $uri/ = 404;
    }
}
EOF
sudo service nginx stop
sudo service nginx start