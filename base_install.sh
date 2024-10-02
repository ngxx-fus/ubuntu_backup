#!/bin/bash
# req: 
printf "\nYou must install sshpass!\n"
# sudo apt install sshpass -y
printf "\nRunning <sudo su>...\n"
password=3568
sshpass -p "$password" "sudo su"

######## system update #######
printf "\nUpdate/update system...\n"
sudo apt update -y
sudo apt upgrade -y

########### gedit #############
printf "\nInstalling gedit...\n"
sudo snap install gedit

######### gnome-tweaks #######
printf "\nInstall gnome-tweaks...\n"
sudo add-apt-repository universe && sudo apt install gnome-tweak-tool -y
sudo apt search gnome-shell-extension -y

###### disable sync time ######
printf "\nDisable time-sync...\n"
timedatectl set-local-rtc 1

########### sushi ############
printf "\nInstall gnome-sushi...\n"
sudo apt-get install gnome-sushi -y

###### extension manager #####
printf "\nInstall exntension-manager...\n"
sudo apt install gnome-shell-extension-manager

########## flatpak ###########
printf "\nInstall flatpak...\n"
sudo apt install flatpak -y
sudo apt install gnome-software-plugin-flatpak -y
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

