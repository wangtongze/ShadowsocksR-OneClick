ShadowsocksR-OneClick
Only one click to install Shadowsocks-RSS(server) on your Ubuntu or Debian and start to proxy your traffic

#一键安装Shadowsocks-RSS服务端于Ubuntu或Debian系统上并开始加密你的所有流量，突破GFW的封锁

使用方法：

Ubuntu/Debian(可以在任意路径运行此脚本):

chmod +x ssr-server.sh && ./ssr-server.sh

#脚本运行完后，SS-R会在后台自动运行。想要更改SS-R状态的话，请cd至运行ssr-server.sh的路径并执行以下操作：

停止SS-R：
bash shadowsocks/shadowsocks/stop.sh

开始SS-R：
bash shadowsocks/shadowsocks/start.sh

查看SS-R运行log：
bash shadowsocks/shadowsocks/tail.sh

#其他信息参见
https://github.com/breakwa11/shadowsocks-rss/wiki/Server-Setup
