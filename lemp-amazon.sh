#!/usr/bin/env bash

# Install linux update
sudo yum update -y

# Install MySQL
sudo yum install https://dev.mysql.com/get/mysql80-community-release-el7-5.noarch.rpm -y
sudo amazon-linux-extras install epel -y
sudo yum install mysql-community-server -y

# Install NGINX
sudo amazon-linux-extras install nginx1.12 -y

# Install PHP and PHP-FPM
sudo amazon-linux-extras install php8.1 -y

# Configure NGINX
sudo cat > /etc/nginx/conf.d/default.conf << 'EOF'
server {
  listen 80;
  listen [::]:80;
  server_name _;

  location / {
    root   /usr/share/nginx/html;
    index  index.php index.html index.htm;
  }

  location ~ \.php$ {
    root /usr/share/nginx/html;
    fastcgi_pass   unix:/run/php-fpm/www.sock;
    fastcgi_index  index.php;
    fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include        fastcgi_params;
  }
}
EOF

# Add a test.php to /usr/share/nginx/html
sudo bash -c "echo '<?php phpinfo(); ?>' > /usr/share/nginx/html/test.php"

# Add MySQL, NGINX, and PHP-FPM service start to boot sequence
sudo chkconfig mysqld on
sudo chkconfig nginx on
sudo chkconfig php-fpm on

# Start MySQL, NGINX, and PHP-FPM service
sudo service mysqld start
sudo service nginx start
sudo service php-fpm start

# Install Certbot and procure an SSL Certificate
# sudo wget -r --no-parent -A 'epel-release-*.rpm' https://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/
# sudo rpm -Uvh dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-*.rpm
# sudo yum-config-manager --enable epel*
# sudo amazon-linux-extras install epel -y
# sudo yum install certbot python-certbot-nginx -y 
# sudo certbot certonly --nginx -d fls.red

# sudo grep 'temporary password' /var/log/mysqld.log