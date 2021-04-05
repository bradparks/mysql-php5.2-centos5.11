#!/usr/bin/env bash

P=`pwd`
docker run \
  -d \
  -p 49160:80 \
  -v ${P}/data:/data \
  -v ${P}/www:/var/www/html \
  php-5.2-apache-v1
