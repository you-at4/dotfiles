#!/bin/bash

# コマンドラインからuser 名を取得
user=${1}

#adduser -m $user
# sudo グループに追加
gpasswd -a $user sudo

sudo bash -c "echo \"${user} ALL=(root) NOPASSWD: ALL\" >> /etc/sudoers.d/nonpass_sudo"
sudo chmod 0440 /etc/sudoers.d/nonpass_sudo
sudo visudo -c

# パッケージの取得先を日本サーバーに変更
sudo sed -i 's/\/archive\.ubuntu/\/jp\.archive\.ubuntu/' /etc/apt/sources.list

sudo apt update
sudo apt upgrade -y

# 日本語化(これをやらないと 一部日本語のファイル名が文字化けする)
echo "Asia/Tokyo" | sudo tee /etc/timezone
sudo rm /etc/localtime
sudo dpkg-reconfigure --frontend noninteractive tzdata
sudo apt install -y language-pack-ja
sudo apt install -y manpages-ja
sudo update-locale LANG=ja_JP.UTF-8

#sudo apt install zsh

# ついでにシンボリックリンクを作る
cd ~
ln -s "/mnt/c/Users/jimu01/" ~/winhome
ln -s "/mnt/c/develop/" ~/develop

# gitが余計なお世話をしないように変更
git config --global core.autoCRLF false

exit
