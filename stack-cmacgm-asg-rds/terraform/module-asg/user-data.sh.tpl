#!/bin/bash -x

db_username=${RDS_USERNAME}
db_user_password=${RDS_PASSWORD}
db_name=${RDS_DB_NAME}
db_RDS=${RDS_ENDPOINT}

cd /var/www/html
wp config set DB_USER $db_username --allow-root
wp config set DB_PASSWORD $db_user_password --allow-root
wp config set DB_NAME $db_name --allow-root
wp config set DB_HOST $db_RDS --allow-root

systemctl restart httpd.service