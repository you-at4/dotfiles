#!/bin/bash

if [ "$UID" -ne 0 ];then
  echo "non-root user! please exec root user."
  exit
fi

# fish と fishermanをインストール(fishの最新版を取得するためにリポジトリを追加する)
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/2/Debian_8.0/ /' > /etc/apt/sources.list.d/fish.list 
wget -nv https://download.opensuse.org/repositories/shells:fish:release:2/Debian_8.0/Release.key -O Release.key
apt-key add - < Release.key
apt update
apt install fish -y

# fisherman のインストール
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisherman | fish

exit

