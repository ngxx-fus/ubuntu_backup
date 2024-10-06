#!/bin/bash
# req:
#	sshpass

#clear screen
printf "Clear screen after 3 seconds!\n"
sleep 3s
clear

#Note:
printf "\e[33mNote:\e[0m\n"
printf "\tDuring the installation, anytime you want to \e[33mabort\e[0m, \n\tjust spam \e[91mctrl+z\e[0m\e[0m\n"
printf "\tSome app doesn't be installed (e.g chrome, edge)\n"

password=""
printf "\e[33mEnter your password: \e[0m"
read -s password

# Check are sshpass, neofetch installed?
installed_both=''
printf "\e[33m\nPre-install check:\e[0m\n\tAre you installed both sshpass and neofetch? y/n "
while true; do
    read yn
    case $yn in
        [Yy]* ) installed_both=1; break;;
        [Nn]* ) installed_both=0; break;;
        * ) echo "Please answer correct form!\n";;
    esac
done

if [ $installed_both -eq 0 ];
then
    while true; do
        printf "\e[33mPre-install:\e[0m\n\tWould you like to install sshpass and neofetch? y/n \e[0m"
        read yn
        case $yn in
            [Yy]* ) sshpass -p "$password" sudo apt install sshpass neofetch -y; break;;
            [Nn]* ) printf "Abort installtion!\n"; exit;;
            * ) echo "Please answer correct form!\n";;
        esac
    done
fi

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
sshpass -p "$password" sudo apt install gnome-shell-extension-manager -y

########## flatpak ###########
printf "\n\e[96mInstall flatpak...\e[0m\n"
sshpass -pm viết bài này, 6 kiến ​​trúc chính (arm "$password" sudo apt install flatpak -y
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
    printf "\e[91mFile existed -> aborted! \e[0m\n"
fi

printf "\n\e[96mCopying custom fonts ...\e[0m\n"
sshpass -p "$password" sudo cp -rf ./fonts /usr/share/fonts/truetype

printf "\n\e[96mAdding Initial_Script alias ~/.bashrc\e[0m\n"
echo "$(cat ./bash/alias)" >> ~/.bashrc

printf "\n\e[96mAdding Initial_Script into ~/.bashrc\e[0m\n"
echo "$(cat ./bash/initial_script)" >> ~/.bashrc

printf "\n\n--------------------- DONE! ---------------------\n\n" 
