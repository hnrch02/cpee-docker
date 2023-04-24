#!/bin/bash
apt-get update
apt-get install --no-install-recommends -y ruby redis nginx
apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

mkdir -p /cpee /var/log/cpee

cd /cpee
cpee new flow
cpee-instantiation instantiation
cpee-logging-xes-yaml new log
cpee cpui ui

cd /cpee/flow
sed -i '/use CPEE::implementation(opts)/e cat /build/config/cpee.rb' cpee
ln -s /run/redis.sock redis.sock

cd /var/www
ln -s /cpee/log/logs
ln -s /cpee/ui flow
ln -s /cpee/ui/js_libs js_libs

cd /build
cp index.html /var/www/index.html
cp config.json /var/www/flow/config.json
cp config/nginx-localhost.conf /etc/nginx/sites-available/default
cp config/redis.conf /etc/redis/redis.conf

cd /build/runit
for service in *
do
  mkdir /etc/service/$service
  cp $service /etc/service/$service/run
  chmod +x /etc/service/$service/run
done

rm -rf /build