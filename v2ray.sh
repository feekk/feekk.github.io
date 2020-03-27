#!/bin/sh

echo "alias installbaota='wget -O install.sh http://download.bt.cn/install/install_6.0.sh && bash install.sh'" >> /root/.bashrc 
echo " " >>  /root/.bashrc 

echo '{"inbound":{"streamSettings":{"network":"tcp"},"protocol":"vmess","port":80,"settings":{"clients":[{"alterId":100,"security":"auto","id":"9ce741b7-f27e-4d41-8510-a4994e8ee727","level":1}]}},"outboundDetour":[{"tag":"blocked","protocol":"blackhole","settings":{}}],"outbound":{"protocol":"freedom","settings":{}},"log":{"access":"/var/log/v2ray/access.log","loglevel":"info","error":"/var/log/v2ray/error.log"},"routing":{"settings":{"rules":[{"ip":["0.0.0.0/8","10.0.0.0/8","100.64.0.0/10","127.0.0.0/8","169.254.0.0/16","172.16.0.0/12","192.0.0.0/24","192.0.2.0/24","192.168.0.0/16","198.18.0.0/15","198.51.100.0/24","203.0.113.0/24","::1/128","fc00::/7","fe80::/10"],"type":"field","outboundTag":"blocked"}]},"strategy":"rules"}}' > /root/v2ray.config
echo " " 

echo '{"tls":"off","status":"on","domain":"none","encrypt":"auto","uuid":"9ce741b7-f27e-4d41-8510-a4994e8ee727","ip":"","mux":"on","secret":"44369f5382d51e6fcc4c254d1fc43820","protocol":"vmess","trans":"tcp","port":"80"}' >/root/v2ray.Fun.config 
echo " "

apt-get install expect -y
wget -N --no-check-certificate https://raw.githubusercontent.com/FunctionClub/V2ray.Fun/master/install.sh -O /root/install.sh

echo '#!/usr/bin/expect -f
set timeout -1
spawn echo "start expect" > /root/start.log
spawn bash install.sh
expect "*请输入默认用户名*"
send "feek\r"
expect "*请输入默认登录密码*"
send "feek\r"
expect "*请输入监听端口号*"
send "444\r"
spawn echo "finish expect" >> /root/start.log
interact' >  /root/iv2ray.sh

chmod +x /root/iv2ray.sh 
expect /root/iv2ray.sh

mv /etc/v2ray/config.json /etc/v2ray/config.json.bak
mv /usr/local/V2ray.Fun/v2ray.config /usr/local/V2ray.Fun/v2ray.config.bak
cp /root/v2ray.config /etc/v2ray/config.json
cp /root/v2ray.Fun.config /usr/local/V2ray.Fun/v2ray.config
systemctl restart v2ray