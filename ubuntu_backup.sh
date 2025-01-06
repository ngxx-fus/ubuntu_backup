#!/bin/bash

####### [1] TEXT EFFECT #######
BOLD="\e[1m"
FAINT="\e[2m"
ITALICS="\e[3m"
UNDERLINED="\e[4m"

####### [2] TEXT COLOR #######
BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MEGENTA="\e[35m"
CYAN="\e[36m"
LIGHT_GRAY="\e[37m"
GRAY="\e[90m"
LIGHT_RED="\e[91m"
LIGHT_GREEN="\e[92m"
LIGHT_YELLOW="\e[93m"
LIGHT_BLUE="\e[94m"
LIGHT_MEGENTA="\e[95m"
LIGHT_CYAN="\e[96m"
WHITE="\e[m97"

####### [3] BACKGROUND COLOR #######
BG_BLACK="\e[40m"
BG_RED="\e[41m"
BG_GREEN="\e[42m"
BG_YELLOW="\e[43m"
BG_BLUE="\e[44m"
BG_MEGENTA="\e[45m"
CYAN="\e[46m"
BG_LIGHT_GRAY="\e[47m"
BG_GRAY="\e[100m"
BG_LIGHT_RED="\e[101m"
BG_LIGHT_GREEN="\e[102m"
BG_LIGHT_YELLOW="\e[103m"
BG_LIGHT_BLUE="\e[104m"
BG_LIGHT_MEGENTA="\e[105m"
BG_LIGHT_CYAN="\e[106m"
BG_WHITE="\e[m107"

####### RESET #######
NORMAL="\e[0m"

#clear screen
printf "Clear screen after 3 seconds!\n"
sleep 3s
clear

printf "Install the dependancies:\n"
printf "1. ${YELLOW}<sshpass>${NORMAL}\n"
sudo apt install sshpass -y
printf "1. ${YELLOW}<neofetch>${NORMAL}\n"
sudo apt install neofetch -y

#Note:
printf "\e[33mNote:\e[0m\n"
printf "\tDuring the installation, anytime you want to \e[33mabort\e[0m, \n\tjust spam \e[91mctrl+z\e[0m\e[0m\n"
printf "\tSome app doesn't be installed (e.g chrome, edge)\n"

password=""
printf "\e[33mEnter your password: \e[0m"
read -s password

printf "\e[92m\nForce run: ${BOLD} update, upgrade${NORMAL}\n"
sshpass -p "$password" sudo apt update -y
sshpass -p "$password" sudo apt upgrade -y

printf "\e[92m\nForce install: ${BOLD}sshpasss, neofetch, curl ${NORMAL}${NORMAL}\n"
sshpass -p "$password" sudo apt install sshpass -y
sshpass -p "$password" sudo apt install  neofetch -y
sshpass -p "$password" sudo apt install  curl -y

# Check are sshpass, neofetch installed?
# installed_both=''
# printf "\e[33m\nPre-install check:\e[0m\n\tAre you installed both sshpass and neofetch? y/n "
# while true; do
#     read yn
#     case $yn in
#         [Yy]* ) installed_both=1; break;;
#         [Nn]* ) installed_both=0; break;;
#         * ) echo "Please answer correct form!\n";;
#     esac
# done

# if [ $installed_both -eq 0 ];
# then
#     while true; do
#         printf "\e[33mPre-install:\e[0m\n\tWould you like to install sshpass and neofetch? y/n \e[0m"
#         read yn
#         case $yn in
#             [Yy]* ) sshpass -p "$password" sudo apt install sshpass neofetch -y; break;;
#             [Nn]* ) printf "Abort installtion!\n"; exit;;
#             * ) echo "Please answer correct form!\n";;
#         esac
#     done
# fi

#printf "\nChange user to ROOT...\n"
printf "System print informations via neofetch\n"
sshpass -p "$password"  sudo neofetch

printf "\e[33mInstallion list:\e[0m"
printf "\nexntension-manager"
printf "\npython-is-python3"
printf "\npython3-venv"
printf "\ngnome-tweaks"
printf "\noh-my-posh"
printf "\nflatpak"
printf "\nOBS"
printf "\nduf"
printf "\nvlc"
printf "\ngit"

printf "\e[33m\nUpdate/Upgrade/Change list:\e[0m"
printf "\nUpdate&Upgrade system"
printf "\ndisable sync time"

printf "\e[33m\nAlias list:\e[0m\n"
echo -e "$(cat ./bash/alias)"

printf "\e[33m\nInitial script:\e[0m\n"
echo "$(cat ./bash/initial_script)"

printf "\e[33m\nContinue? y/n \e[0m"
while true; do
    read yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer correct form!\n";;
    esac
done

######## system update #######
printf "\n\e[96mUpdate/update system...\e[0m\n"
sshpass -p "$password" sudo apt update -y
sshpass -p "$password" sudo apt upgrade -y

########### gedit #############
#printf "\ne[96mInstall gedit...\e[0m\n"
#sshpass -p "$password" sudo snap install gedit

printf "\n\e[96mInstall git\e[0m\n"
sshpass -p "$password" sudo apt install git -y

######### gnome-tweaks #######
printf "\n\e[96mInstall gnome-tweaks...\e[0m\n"
sshpass -p "$password" sudo add-apt-repository universe -y 
sshpass -p "$password" sudo apt install gnome-tweak-tool -y
sshpass -p "$password" sudo apt search gnome-shell-extension -y

###### disable sync time ######
printf "\n\e[96mDisable time-sync...\e[0m\n"
timedatectl set-local-rtc 1

########### sushi ############
printf "\n\e[96mInstall gnome-sushi...\e[0m\n"
sshpass -p "$password" sudo apt-get install gnome-sushi -y

###### extension manager #####
printf "\n\e[96mInstall exntension-manager...\e[0m\n"
sshpass -p "$password" sudo add-apt-repository ppa:gnome-shell-extensions/ppa  -y
sshpass -p "$password" sudo apt update  -y
sshpass -p "$password" sudo apt upgrade  -y
sshpass -p "$password" sudo apt install gnome-shell-extension-manager  -y
########## flatpak ###########
printf "\n\e[96mInstall flatpak...\e[0m\n"
sshpass -p "$password" sudo apt install flatpak -y
sshpass -p "$password" sudo apt install gnome-software-plugin-flatpak -y
sshpass -p "$password" sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

############ obs ############
printf "\n\e[96mInstall OBS...\e[0m\n"
sshpass -p "$password" sudo add-apt-repository ppa:obsproject/obs-studio -y
sshpass -p "$password" sudo apt update  -y
sshpass -p "$password" sudo apt install ffmpeg obs-studio  -y

########### python ##########
printf "\n\e[96mInstall python3-venv pkg...\e[0m\n"
#venv for python3 
sshpass -p "$password" sudo apt install python3-venv  -y

#python is python3 
printf "\n\e[96mInstall python-is-python3 pkg...\e[0m\n\n"
sshpass -p "$password" sudo apt install python-is-python3  -y

#oh-my-posh
printf "\n\e[96mInstall oh-my-posh\e[0m\n"
curl -s https://ohmyposh.dev/install.sh | bash -s 

#duf
prinf "\n\e[96mInstall duf\e[0m\n"
sshpass -p "$password" sudo apt install duf  -y

#neofetch
printf "\n\e[96mInstall neofetch...\e[0m\n"
sshpass -p "$password" sudo apt install duf  -y

#vlc
printf "\n\e[96mInstall vlc...\e[0m\n"
sshpass -p "$password" sudo apt install vlc -y

printf "\n\e[96mCopying custom theme into $USER dir...\e[0m\n"
if [ -d "~/.OH-MY-POSH" ]; then
    cp -rf ./OH-MY-POSH/ ~/.OH-MY-POSH
else
    cp -rf ./OH-MY-POSH/ ~/.OH-MY-POSH
    printf "\e[91mFile existed -> aborted! \e[0m\n"
fi

printf "\n\e[96mCopying custom fonts ...\e[0m\n"
sshpass -p "$password" sudo cp -rf ./fonts /usr/share/fonts/truetype

printf "\n\e[96mAdding Initial_Script alias ~/.bashrc\e[0m\n"
echo "$(cat ./bash/alias)" >> ~/.bashrc

printf "\n\e[96mAdding Initial_Script into ~/.bashrc\e[0m\n"
echo "$(cat ./bash/initial_script)" >> ~/.bashrc

printf "\n\n--------------------- DONE! ---------------------\n\n" 
