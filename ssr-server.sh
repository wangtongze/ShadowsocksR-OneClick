#!/bin/sh
if [ `id -u` -ne 0 ] 
then
  echo "Need root, try with sudo"
  exit 0
fi

echo ""
echo "Welcome to use SSR-server one click install script"
echo "Made by WangTongze WEBSITE: wangtongze.tk"
echo ""

apt-get update
apt-get -y install python-pip
apt-get -y install m2crypto git


git clone -b manyuser https://github.com/breakwa11/shadowsocks.git


IP=`wget -q -O - http://api.ipify.org`

if [ "x$IP" = "x" ]
then
  echo "============================================================"
  echo "  !!!  COULD NOT DETECT SERVER EXTERNAL IP ADDRESS  !!!"
  echo "============================================================"
else
  echo "============================================================"
  echo "Detected your server external ip address: $IP"
  echo "============================================================"
fi

dir=`pwd`
ss="/shadowsocks"
cd $dir$ss

cat > config.json << END
{
    "server":"$IP",
    "server_port":443,
    "local_address": "127.0.0.1",
    "local_port":1080,
    "password":"wangtongze.tk",
    "timeout":300,
    "method":"rc4-md5",
    "fast_open": false,
    "workers": 1
}
END
cd $dir$ss$ss
chmod +x *.sh
./run.sh
cd $dir
iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT
iptables-save
exit 0
