#!/bin/bash

printf "\nmsg:\tsource:\tTextEffects.sh"
source ./Resources/TextEffects.sh
printf "\nmsg:\tsource:\tFunctions.sh"
source ./Resources/Functions.sh

#clear screen
printf "\nClear screen after 3 seconds!\n"
sleep 3s
clear

#Note:
printf "\e[33mNote:${NORM}\n"
printf "\tDuring the installation, anytime you want to \e[33mabort${NORM}, \n\tjust spam \e[91mctrl+z${NORM}${NORM}\n"
printf "\tSome app doesn't be installed (e.g chrome, edge)\n"

############## Install neofetch, curl, sshpass ##############
printf "Force install ${YELLOW}<sshpass>:${NORMAL}\n"
sudo apt install sshpass -y

printf "Force install ${YELLOW}<neofetch>:${NORMAL}\n"
sudo apt install neofetch -y

printf "Force install ${YELLOW}<curl>:${NORMAL}\n"
sudo apt install curl -y

############## Get ```password``` ###########################
password=""
printf "\e[33mEnter your password: ${NORM}"
read -s password

############## Neofetch #####################################
printf "\nSystem print informations via neofetch\n"
sshpass -p "$password"  sudo neofetch
printf "\e[33m\nContinue? y/n ${NORM}"
yes_or_no; if [ $? -eq 0 ]; then exit 0; fi

############## Update, Upgrade system #######################
printf "\e[92m\nRun: ${BOLD} update, upgrade${NORMAL}\n"
yes_or_no; if [ $? -eq 1 ]; then
	sshpass -p "$password" sudo apt update -y
	sshpass -p "$password" sudo apt upgrade -y
fi

############## gedit ########################################
#printf "\ne[96mInstall gedit...${NORM}\n"
#sshpass -p "$password" sudo snap install gedit

printf "\n${LIGHT_CYAN}Install git, gh${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	sshpass -p "$password" sudo apt install git -y
	sshpass -p "$password" sudo apt install gh -y
fi

############## gnome-tweaks #################################
printf "\n${LIGHT_CYAN}Install gnome-tweaks...${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	sshpass -p "$password" sudo add-apt-repository universe -y 
	sshpass -p "$password" sudo apt install gnome-tweak-tool -y
	sshpass -p "$password" sudo apt search gnome-shell-extension -y
fi

############## disable sync time ############################
printf "\n${LIGHT_CYAN}Disable time-sync...${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	timedatectl set-local-rtc 1
fi

############## sushi ########################################
printf "\n${LIGHT_CYAN}Install gnome-sushi...${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	sshpass -p "$password" sudo apt-get install gnome-sushi -y
fi

############## extension manager ############################
printf "\n${LIGHT_CYAN}Install exntension-manager...${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	sshpass -p "$password" sudo add-apt-repository ppa:gnome-shell-extensions/ppa  -y
	sshpass -p "$password" sudo apt update  -y
	sshpass -p "$password" sudo apt upgrade  -y
	sshpass -p "$password" sudo apt install gnome-shell-extension-manager  -y
fi

############## flatpak ######################################
printf "\n${LIGHT_CYAN}Install flatpak...${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	sshpass -p "$password" sudo apt install flatpak -y
	sshpass -p "$password" sudo apt install gnome-software-plugin-flatpak -y
	sshpass -p "$password" sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
fi

############## obs ##########################################
printf "\n${LIGHT_CYAN}Install OBS...${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	sshpass -p "$password" sudo add-apt-repository ppa:obsproject/obs-studio -y
	sshpass -p "$password" sudo apt update  -y
	sshpass -p "$password" sudo apt install ffmpeg obs-studio  -y
fi

############## python ########################################
printf "\n${LIGHT_CYAN}Install python3-venv pkg...${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	#venv for python3 
	sshpass -p "$password" sudo apt install python3-venv  -y

	#python is python3 
	printf "\n${LIGHT_CYAN}Install python-is-python3 pkg...${NORM}\n"
	sshpass -p "$password" sudo apt install python-is-python3  -y
fi

############## oh-my-posh ####################################
printf "\n${LIGHT_CYAN}Install oh-my-posh${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	curl -s https://ohmyposh.dev/install.sh | bash -s 
	
	printf "\n${LIGHT_CYAN}Downloads backup theme...${NORM}"
	mkdir -p ~/.oh-my-posh/.themes
	theme_json_url='https://raw.githubusercontent.com/ngxx-fus/ubuntu_backup/refs/heads/main/OH-MY-POSH/theme.json'
	sudo curl -s $theme_json_url > ~/.oh-my-posh/.themes/theme.json
	
	printf "\n${LIGHT_CYAN}Add initial script into .bashrc${NORM}"
	echo '############## oh-my-posh #############' >> ~/.bashrc
	echo 'eval "$(oh-my-posh init bash --config ~/.oh-my-posh/.themes/theme.json)"'  >> ~/.bashrc
	printf "\n"
fi

############## duf ##########################################
printf "\n${LIGHT_CYAN}Install duf${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	sshpass -p "$password" sudo apt install duf
fi

############## vlc ##########################################
printf "\n${LIGHT_CYAN}Install vlc...${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	sshpass -p "$password" sudo apt install vlc -y
fi

############## firefox ######################################
printf "\n${LIGHT_CYAN}Custom Firefox theme...${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	root_profile_path=''
	printf "\nStep 1. Open Firefox, go to \`about:config\`, then change \`toolkit.legacyUserProfileCustomizations.stylesheets\` to \`true\`"
	printf "\nStep 2. Go to \`about:profiles\`, then copy the \`Root Directory\` and paste into the question below.\n"
	read -p "Enter \`Root Directory\` path: " root_profile_path
	printf  "\nThe \`Root Directory\` is: $root_profile_path"
	printf 	"\nCopying \`chrome\` directory into \`root_profile_path\`..."
	sshpass -p $password sudo cp -rf ./FirefoxCSS/chrome $root_profile_path
	printf "\nStep 3. Manually restart the Firefox!"

fi

############## install fonts ################################
printf "\n${LIGHT_CYAN}Copying custom fonts ...${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	sshpass -p "$password" sudo cp -rf ./fonts /usr/share/fonts/truetype
fi
############## insert alias script ##########################
printf "\n${LIGHT_CYAN}Adding Initial_Script alias ~/.bashrc${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	echo "$(cat ./bash/alias)" >> ~/.bashrc
fi

############## insert initial script ########################
printf "\n${LIGHT_CYAN}Adding Initial_Script into ~/.bashrc${NORM}\n"
yes_or_no; if [ $? -eq 1 ]; then
	echo "$(cat ./bash/initial_script)" >> ~/.bashrc
fi

printf "\n\n--------------------- DONE! ---------------------\n\n" 
