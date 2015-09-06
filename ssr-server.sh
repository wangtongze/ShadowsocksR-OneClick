#!/bin/bash
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
apt-get -y install python-pip openssl
apt-get -y install python-m2crypto git


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

head="ss://"
A="rc4-md5:wangtongze.tk@"
B=":443"

STR=`openssl enc -base64 <<< $A$IP$B`
#STR=`echo $A$IP$B | base64`
string=`echo ${STR/o=/==}`

#generate the QR code
web="https://api.qrserver.com/v1/create-qr-code/?size=300x300&data="$head$string
echo "===================================================================="
echo "Get your server QR code on:"
echo $web
echo "===================================================================="
echo "Shadowsocks-RSS server info"
echo "Server ip: $IP"
echo "Port: 443"
echo "Password: wangtongze.tk"
echo "Method: rc4-md5"
echo "Local_port: 1080"
echo "===================================================================="
echo "If you want to get the lastest client of Shadowsocks-RSS"
echo "please go to http://wangtongze.tk"
echo "===================================================================="
exit 0
