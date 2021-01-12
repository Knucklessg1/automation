#!/bin/bash

echo "Updating First"
sudo ./os_upgrade.sh

echo "Installing all applications"
sudo ./chrome_install.sh
sudo ./nfs_install.sh
sudo ./openssh_install.sh
sudo ./python_install.sh
sudo ./python_update.sh
sudo ./kvm_install.sh
sudo ./ffmpeg_install.sh
sudo ./vlc_install.sh
sudo ./tmux_install.sh
sudo ./video_rename install_dependencies
sudo ./steam_install.sh
sudo ./git_install.sh
sudo ./docker_install.sh
sudo ./gimp_install.sh
sudo ./transmission_client.sh install_dependencies
sudo ./gparted_install.sh
sudo ./dos2unix_install.sh
sudo ./adb_install.sh
sudo ./wireshark_install.sh
sudo ./hypnotix_install.sh
echo "System Provisioned Successfully"
