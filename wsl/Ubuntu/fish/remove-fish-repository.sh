#!/bin/bash

if [ "$UID" -ne 0 ];then
  echo "non-root user! please exec root user."
  exit
fi

fishkey=""
keylist=$(apt-key list)
# apt-key でfish該当部分の前1行を含めて変数に代入
key=$(echo "$keylist" | grep -B 1 "fish OBS Project") 
echo "$key"
if [ "$key" != "" ]; then
    fishkey=$(echo "$key" | sed -ne 's!^pub   [A-Z0-9]\{5\}/\([A-Z0-9]\{8\}\) .*$!\1!p')
else
    echo "$keylist"
    echo -e "for example apt-key is this greenback code 2048R/\e[37;42;1mD880C8E4\e[m\n"
    read -p "please input fish repository apt-key:" fishkey
fi
echo "Delete fish repository apt-key:$fishkey"
sudo apt-key del ${fishkey}

#ls /etc/apt/sources.list.d/
#read -p "Delete repository:" delrepo
echo "Remove fish repository"
sudo rm -f /etc/apt/sources.list.d/fish.list

echo -e "\e[32;4mfish fish repository successful!\e[m\n\n"
read -p "press enter"

