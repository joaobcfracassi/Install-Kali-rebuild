#!/bin/bash

echo "##################################################################################################"
echo "########################                                        ##################################"
echo "########################                                        ##################################"
echo "######################## Kali Linux Rebuild Automated Install   ##################################"
echo "########################                                        ##################################"
echo "######################## Modo de uso: ./install-kali-rebuild.sh ##################################"
echo "########################                                        ##################################"
echo "########################                                        ##################################"
echo "##################################################################################################"

read -p "Deseja continuar? [y/n] " op

if [ $op == "y"];
then
	echo "Update system...."
	sudo apt update; sudo apt upgrade -y; sudo apt dist-upgrade -y

	echo "Install Python Impacket Package..."
	sudo apt install python3-venv python3-pip -y
	cd /opt; sudo git clone https://github.com/SecureAuthCorp/impacket.git
	cd impacket; sudo pip3 install . 
	sudo python3 setup.py install 

	echo "Install LibreOffice PT-BR..."
	sudo apt install libreoffice libreoffice-help-pt-br libreoffice-l10n-pt-br -y

	echo "Install Ncat..."
	sudo apt install ncat -y

	echo "Install Sublime Text..."
	cd /opt; wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
	sudo apt install apt-transport-https
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
	sudo apt update; sudo apt install sublime-text -y

	echo "Install and configure Tor-Browser..."
	sudo apt install tor proxychains -y; sudo echo "socks5  127.0.0.1 9050" >> /etc/proxychains.conf

	echo "Install Telegram..."
	if [ $(uname -r | grep "amd64") ];then
		wget "https://telegram.org/dl/desktop/linux" -O telegram.tar.xz
	else
		wget "https://telegram.org/dl/desktop/linux32" -O telegram.tar.xz
	fi

	sudo tar Jxf telegram.tar.xz -C /opt/
	sudo mv /opt/Telegram*/ /opt/telegram
	sudo ln -sf /opt/telegram/Telegram /usr/bin/telegram
	echo -e '[Desktop Entry]\n Version=1.0\n Exec=/opt/telegram/Telegram\n Icon=Telegram\n Type=Application\n Categories=Application;Network;' | sudo tee /usr/share/applications/telegram.desktop
	sudo chmod +x /usr/share/applications/telegram.desktop

	if [ $(echo $LANG) == "pt_BR.UTF-8" ];then
		cp /usr/share/applications/telegram.desktop  ~/Área\ de\ Trabalho/
	else
		cp /usr/share/applications/telegram.desktop ~/Desktop
	fi

	echo "Install Seclist..."
	sudo apt install seclists -y

	echo "Install KeypassX..."
	sudo apt install keypassx -y

	echo "Install Google Chrome..."
	if [ $(uname -r | grep "amd64") ];then
		cd /opt; wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O chrome.deb
		sudo dpkg -i chrome.deb; sudo apt install -f
	fi

	echo "Install Remmina..."
	sudo apt install remmina -y

	echo "Install Thunderbird Mail Client..."
	sudo apt install Thunderbird -y

	echo "Install Python Labrary..."
	sudo pip install paramiko
	sudo pip install requests
	sudo pip install bs4

	echo "Install fcrackzip..."
	sudo apt install fcrackzip -y

	echo "Install debugger..."
	sudo apt install gdb edb-debugger strace ltrace -y

	echo "Install gobuster..."
	sudo apt install gobuster -y

	echo "Install GCC para Windows..."
	sudo apt install mingw-w64 wine -y
	sudo dpkg --add-architecture i386 && sudo apt-get update -y && sudo apt-get install wine32 -y
	
	echo "Install dirsearch..."
	cd /opt; sudo git clone https://github.com/maurosoria/dirsearch.git
	#cd dirsearch
	#python3 dirsearch.py -u http://10.10.10.28 -e php

	echo "Install python pip 2..."
	cd /opt; sudo curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	sudo python2 ./get-pip.py
	sudo rm get-pip.py
else
	echo "Saindo do programa..."
	exit
fi
