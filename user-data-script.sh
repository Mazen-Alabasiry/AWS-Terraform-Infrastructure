#!/bin/bash
sudo -i
sudo yum install httpd -y
sudo systemctl enable httpd
sudo systemctl start httpd
sudo systemctl restart httpd
echo "<h1>Welcome to my website <h1>" > /var/www/html/index.html