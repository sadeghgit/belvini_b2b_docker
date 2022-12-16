#!/bin/bash

docker-compose -f ./docker-compose.yml up -d --build

sudo  sed -in-place '/127.0.0.1 local.b2b.de/d' /etc/hosts
sudo  -- sh -c -e " echo 127.0.0.1  local.b2b.de >> /etc/hosts"

php   " echo
===================== 🚀 Done 🚀 ===================

      Belvini Magento Setup was successful!

      🌎 Domain: https://local.b2b.de/admin
      🌎 Domain: http://0.0.0.0:3000 (It needs 10 seconds for the engine to load!)


===================== 🚀 Done 🚀 ==================="

docker exec -it php-fpm-mg2 bash
#docker exec -it magento-mg2 bash