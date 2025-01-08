#! /bin/sh

printf "\nmsg:\tsource:\tTextEffects.sh"
source /mnt/sda1/linux_downloads/ubuntu_backup/Resources/TextEffects.sh

printf "\nmsg:\trunning\tFunctions.sh"
yes_or_no(){
	while true; 
	do
		printf "${BOLD}Y/N?${GRAY}[Y]${NORMAL}"
		read -n 1 -p ' ' yn
		if [ -z "$yn" ]; then
			return 1;
		fi
		case $yn in
        		[Yy]* )   return 1;;
			[Nn]* )   return 0;;
        		* ) printf "\nPlease enter correct form!\n";;
        	esac
    	done
}
