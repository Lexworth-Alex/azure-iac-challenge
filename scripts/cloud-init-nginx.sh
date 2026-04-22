#!/bin/bash
apt-get update -y
apt-get install -y nginx
HOSTNAME=$(hostname)
cat <<EOF >/var/www/html/index.html
<html>
  <body>
    <h1>Hello from ${HOSTNAME}</h1>
    <p>Azure VM Scale Set behind Application Gateway</p>
  </body>
</html>
EOF
systemctl enable nginx
systemctl restart nginx
