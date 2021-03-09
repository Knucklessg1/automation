#!/bin/bash

# Create Ubuntu Preseed
function create_preseed(){
  echo '
#### Contents of the preconfiguration file (for stretch)
### Localization
# Preseeding only locale sets language, country and locale.
d-i debian-installer/locale string en_US

# The values can also be preseeded individually for greater flexibility.
d-i debian-installer/language string en
d-i debian-installer/country string NL
d-i debian-installer/locale string en_GB.UTF-8
# Optionally specify additional locales to be generated.
#d-i localechooser/supported-locales multiselect en_US.UTF-8, nl_NL.UTF-8

# Keyboard selection.
# Disable automatic (interactive) keymap detection.
d-i console-setup/ask_detect boolean false
d-i keyboard-configuration/xkb-keymap select us
# To select a variant of the selected layout:
#d-i keyboard-configuration/xkb-keymap select us(dvorak)
# d-i keyboard-configuration/toggle select No toggling

### Network configuration
# Disable network configuration entirely. This is useful for cdrom
# installations on non-networked devices where the network questions,
# warning and long timeouts are a nuisance.
#d-i netcfg/enable boolean false

# netcfg will choose an interface that has link if possible. This makes it
# skip displaying a list if there is more than one interface.
d-i netcfg/choose_interface select auto

# To set a different link detection timeout (default is 3 seconds).
# Values are interpreted as seconds.
#d-i netcfg/link_wait_timeout string 10

# If you have a slow dhcp server and the installer times out waiting for
# it, this might be useful.
#d-i netcfg/dhcp_timeout string 60
#d-i netcfg/dhcpv6_timeout string 60

# If you prefer to configure the network manually, uncomment this line and
# the static network configuration below.
#d-i netcfg/disable_autoconfig boolean true

# If you want the preconfiguration file to work on systems both with and
# without a dhcp server, uncomment these lines and the static network
# configuration below.
#d-i netcfg/dhcp_failed note
#d-i netcfg/dhcp_options select Configure network manually

# Static network configuration.
#
# IPv4 example
#d-i netcfg/get_ipaddress string 192.168.1.42
#d-i netcfg/get_netmask string 255.255.255.0
#d-i netcfg/get_gateway string 192.168.1.1
#d-i netcfg/get_nameservers string 192.168.1.1
#d-i netcfg/confirm_static boolean true
#
# IPv6 example
#d-i netcfg/get_ipaddress string fc00::2
#d-i netcfg/get_netmask string ffff:ffff:ffff:ffff::
#d-i netcfg/get_gateway string fc00::1
#d-i netcfg/get_nameservers string fc00::1
#d-i netcfg/confirm_static boolean true

# Any hostname and domain names assigned from dhcp take precedence over
# values set here. However, setting the values still prevents the questions
# from being shown, even if values come from dhcp.
d-i netcfg/get_hostname string unassigned-hostname
d-i netcfg/get_domain string unassigned-domain

# If you want to force a hostname, regardless of what either the DHCP
# server returns or what the reverse DNS entry for the IP is, uncomment
# and adjust the following line.
#d-i netcfg/hostname string somehost

# Disable that annoying WEP key dialog.
d-i netcfg/wireless_wep string
# The wacky dhcp hostname that some ISPs use as a password of sorts.
#d-i netcfg/dhcp_hostname string radish

# If non-free firmware is needed for the network or other hardware, you can
# configure the installer to always try to load it, without prompting. Or
# change to false to disable asking.
#d-i hw-detect/load_firmware boolean true

### Network console
# Use the following settings if you wish to make use of the network-console
# component for remote installation over SSH. This only makes sense if you
# intend to perform the remainder of the installation manually.
#d-i anna/choose_modules string network-console
#d-i network-console/authorized_keys_url string http://10.0.0.1/openssh-key
#d-i network-console/password password r00tme
#d-i network-console/password-again password r00tme
# Use this instead if you prefer to use key-based authentication
#d-i network-console/authorized_keys_url http://host/authorized_keys

### Mirror settings
# If you select ftp, the mirror/country string does not need to be set.
#d-i mirror/protocol string ftp
d-i mirror/country string manual
d-i mirror/http/hostname string archive.ubuntu.com
d-i mirror/http/directory string /ubuntu
d-i mirror/http/proxy string

# Alternatively: by default, the installer uses CC.archive.ubuntu.com where
# CC is the ISO-3166-2 code for the selected country. You can preseed this
# so that it does so without asking.
#d-i mirror/http/mirror select CC.archive.ubuntu.com

# Suite to install.
#d-i mirror/suite string stretch
# Suite to use for loading installer components (optional).
#d-i mirror/udeb/suite string stretch
# Components to use for loading installer components (optional).
#d-i mirror/udeb/components multiselect main, restricted

### Account setup
# Skip creation of a root account (normal user account will be able to
# use sudo). The default is false; preseed this to true if you want to set
# a root password.
#d-i passwd/root-login boolean false
# Alternatively, to skip creation of a normal user account.
#d-i passwd/make-user boolean false

# Root password, either in clear text
#d-i passwd/root-password password wwg1wga
#d-i passwd/root-password-again password wwg1wga
# or encrypted using a crypt(3)  hash.
#d-i passwd/root-password-crypted password [crypt(3) hash]

# To create a normal user account.
d-i passwd/user-fullname string Ubuntu-VM
d-i passwd/username string ubuntuvm
# Normal users password, either in clear text
#d-i passwd/user-password password insecure
#d-i passwd/user-password-again password insecure
# or encrypted using a crypt(3) hash.
#d-i passwd/user-password-crypted password [crypt(3) hash]
# Create the first user with the specified UID instead of the default.
#d-i passwd/user-uid string 1010
# The installer will warn about weak passwords. If you are sure you know
# what youre doing and want to override it, uncomment this.
#d-i user-setup/allow-password-weak boolean true

# The user account will be added to some standard initial groups. To
# override that, use this.
#d-i passwd/user-default-groups string audio cdrom video

# Set to true if you want to encrypt the first users home directory.
d-i user-setup/encrypt-home boolean false

### Clock and time zone setup
# Controls whether or not the hardware clock is set to UTC.
d-i clock-setup/utc boolean true

# You may set this to any valid setting for $TZ; see the contents of
# /usr/share/zoneinfo/ for valid values.
d-i time/zone string US/Eastern

# Controls whether to use NTP to set the clock during the install
d-i clock-setup/ntp boolean true
# NTP server to use. The default is almost always fine here.
#d-i clock-setup/ntp-server string ntp.example.com

### i386 specific disk storage
# Activate DASD disks
#d-i s390-dasd/dasd string 0.0.0200,0.0.0300,0.0.0400

# DASD configuration; by default dasdfmt (low-level format) if needed
#d-i s390-dasd/auto-format boolean true
#d-i s390-dasd/force-format boolean true

# zFCP activation and configuration
# d-i s390-zfcp/zfcp string 0.0.1b34:0x400870075678a1b2:0x201480c800000000, \
#                           0.0.1b34:0x400870075679a1b2:0x201480c800000000

### Partitioning
## Partitioning example
# If the system has free space you can choose to only partition that space.
# This is only honoured if partman-auto/method (below) is not set.
# Alternatives: custom, some_device, some_device_crypto, some_device_lvm.
#d-i partman-auto/init_automatically_partition select biggest_free

# Alternatively, you may specify a disk to partition. If the system has only
# one disk the installer will default to using that, but otherwise the device
# name must be given in traditional, non-devfs format (so e.g. /dev/sda
# and not e.g. /dev/discs/disc0/disc).
# For example, to use the first SCSI/SATA hard disk:
#d-i partman-auto/disk string /dev/sda
# In addition, youll need to specify the method to use.
# The presently available methods are:
# - regular: use the usual partition types for your architecture
# - lvm:     use LVM to partition the disk
# - crypto:  use LVM within an encrypted partition
d-i partman-auto/method string lvm

# If one of the disks that are going to be automatically partitioned
# contains an old LVM configuration, the user will normally receive a
# warning. This can be preseeded away...
d-i partman-lvm/device_remove_lvm boolean true
# The same applies to pre-existing software RAID array:
d-i partman-md/device_remove_md boolean true
# And the same goes for the confirmation to write the lvm partitions.
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true

# For LVM partitioning, you can select how much of the volume group to use
# for logical volumes.
#d-i partman-auto-lvm/guided_size string max
#d-i partman-auto-lvm/guided_size string 10GB
#d-i partman-auto-lvm/guided_size string 50%

# You can choose one of the three predefined partitioning recipes:
# - atomic: all files in one partition
# - home:   separate /home partition
# - multi:  separate /home, /var, and /tmp partitions
d-i partman-auto/choose_recipe select atomic

# Or provide a recipe of your own...
# If you have a way to get a recipe file into the d-i environment, you can
# just point at it.
#d-i partman-auto/expert_recipe_file string /hd-media/recipe

# If not, you can put an entire recipe into the preconfiguration file in one
# (logical) line. This example creates a small /boot partition, suitable
# swap, and uses the rest of the space for the root partition:
#d-i partman-auto/expert_recipe string                         \
#      boot-root ::                                            \
#              40 50 100 ext3                                  \
#                      $primary{ } $bootable{ }                \
#                      method{ format } format{ }              \
#                      use_filesystem{ } filesystem{ ext3 }    \
#                      mountpoint{ /boot }                     \
#              .                                               \
#              500 10000 1000000000 ext3                       \
#                      method{ format } format{ }              \
#                      use_filesystem{ } filesystem{ ext3 }    \
#                      mountpoint{ / }                         \
#              .                                               \
#              64 512 300% linux-swap                          \
#                      method{ swap } format{ }                \
#              .

# If you just want to change the default filesystem from ext3 to something
# else, you can do that without providing a full recipe.
#d-i partman/default_filesystem string ext4

# The full recipe format is documented in the file partman-auto-recipe.txt
# included in the "debian-installer" package or available from D-I source
# repository. This also documents how to specify settings such as file
# system labels, volume group names and which physical devices to include
# in a volume group.

# This makes partman automatically partition without confirmation, provided
# that you told it what to do using one of the methods above.
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

## Partitioning using RAID
# The method should be set to "raid".
#d-i partman-auto/method string raid
# Specify the disks to be partitioned. They will all get the same layout,
# so this will only work if the disks are the same size.
#d-i partman-auto/disk string /dev/sda /dev/sdb

# Next you need to specify the physical partitions that will be used.
#d-i partman-auto/expert_recipe string \
#      multiraid ::                                         \
#              1000 5000 4000 raid                          \
#                      $primary{ } method{ raid }           \
#              .                                            \
#              64 512 300% raid                             \
#                      method{ raid }                       \
#              .                                            \
#              500 10000 1000000000 raid                    \
#                      method{ raid }                       \
#              .

# Last you need to specify how the previously defined partitions will be
# used in the RAID setup. Remember to use the correct partition numbers
# for logical partitions. RAID levels 0, 1, 5, 6 and 10 are supported;
# devices are separated using "#".
# Parameters are:
# <raidtype> <devcount> <sparecount> <fstype> <mountpoint> \
#          <devices> <sparedevices>

#d-i partman-auto-raid/recipe string \
#    1 2 0 ext3 /                    \
#          /dev/sda1#/dev/sdb1       \
#    .                               \
#    1 2 0 swap -                    \
#          /dev/sda5#/dev/sdb5       \
#    .                               \
#    0 2 0 ext3 /home                \
#          /dev/sda6#/dev/sdb6       \
#    .

# For additional information see the file partman-auto-raid-recipe.txt
# included in the "debian-installer" package or available from D-I source
# repository.

# This makes partman automatically partition without confirmation.
d-i partman-md/confirm boolean true
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true

## Controlling how partitions are mounted
# The default is to mount by UUID, but you can also choose "traditional" to
# use traditional device names, or "label" to try filesystem labels before
# falling back to UUIDs.
#d-i partman/mount_style select uuid

### Base system installation
# Configure a path to the preconfigured base filesystem. This can be used to
# specify a path for the installer to retrieve the filesystem image that will
# be deployed to disk and used as a base system for the installation.
#d-i live-installer/net-image string /install/filesystem.squashfs

# Configure APT to not install recommended packages by default. Use of this
# option can result in an incomplete system and should only be used by very
# experienced users.
#d-i base-installer/install-recommends boolean false

# The kernel image (meta) package to be installed; "none" can be used if no
# kernel is to be installed.
#d-i base-installer/kernel/image string linux-generic

### Apt setup
# You can choose to install restricted and universe software, or to install
# software from the backports repository.
#d-i apt-setup/restricted boolean true
d-i apt-setup/universe boolean true
#d-i apt-setup/backports boolean true
# Uncomment this if you dont want to use a network mirror.
#d-i apt-setup/use_mirror boolean false
# Select which update services to use; define the mirrors to be used.
# Values shown below are the normal defaults.
#d-i apt-setup/services-select multiselect security
#d-i apt-setup/security_host string security.ubuntu.com
#d-i apt-setup/security_path string /ubuntu

# Additional repositories, local[0-9] available
#d-i apt-setup/local0/repository string \
#       http://local.server/ubuntu stretch main
#d-i apt-setup/local0/comment string local server
# Enable deb-src lines
#d-i apt-setup/local0/source boolean true
# URL to the public key of the local repository; you must provide a key or
# apt will complain about the unauthenticated repository and so the
# sources.list line will be left commented out
#d-i apt-setup/local0/key string http://local.server/key

# By default the installer requires that repositories be authenticated
# using a known gpg key. This setting can be used to disable that
# authentication. Warning: Insecure, not recommended.
#d-i debian-installer/allow_unauthenticated boolean true

# Uncomment this to add multiarch configuration for i386
#d-i apt-setup/multiarch string i386


### Package selection
tasksel tasksel/first multiselect ubuntu-desktop
#tasksel tasksel/first multiselect lamp-server, print-server
#tasksel tasksel/first multiselect kubuntu-desktop

# Individual additional packages to install
d-i pkgsel/include string openssh-server build-essential
# Whether to upgrade packages after debootstrap.
# Allowed values: none, safe-upgrade, full-upgrade
#d-i pkgsel/upgrade select none

# Language pack selection
#d-i pkgsel/language-packs multiselect de, en, zh

# Policy for applying updates. May be "none" (no automatic updates),
# "unattended-upgrades" (install security updates automatically), or
# "landscape" (manage system with Landscape).
#d-i pkgsel/update-policy select none

# Some versions of the installer can report back on what software you have
# installed, and what software you use. The default is not to report back,
# but sending reports helps the project determine what software is most
# popular and include it on CDs.
#popularity-contest popularity-contest/participate boolean false

# By default, the systems locate database will be updated after the
# installer has finished installing most packages. This may take a while, so
# if you dont want it, you can set this to "false" to turn it off.
#d-i pkgsel/updatedb boolean true

### Boot loader installation
# Grub is the default boot loader (for x86). If you want lilo installed
# instead, uncomment this:
#d-i grub-installer/skip boolean true
# To also skip installing lilo, and install no bootloader, uncomment this
# too:
#d-i lilo-installer/skip boolean true


# This is fairly safe to set, it makes grub install automatically to the MBR
# if no other operating system is detected on the machine.
d-i grub-installer/only_debian boolean true

# This one makes grub-installer install to the MBR if it also finds some other
# OS, which is less safe as it might not be able to boot that other OS.
d-i grub-installer/with_other_os boolean true

# Due notably to potential USB sticks, the location of the MBR can not be
# determined safely in general, so this needs to be specified:
#d-i grub-installer/bootdev  string /dev/sda
# To install to the first device (assuming it is not a USB stick):
#d-i grub-installer/bootdev  string default

# Alternatively, if you want to install to a location other than the mbr,
# uncomment and edit these lines:
#d-i grub-installer/only_debian boolean false
#d-i grub-installer/with_other_os boolean false
#d-i grub-installer/bootdev  string (hd0,1)
# To install grub to multiple disks:
#d-i grub-installer/bootdev  string (hd0,1) (hd1,1) (hd2,1)

# Optional password for grub, either in clear text
#d-i grub-installer/password password r00tme
#d-i grub-installer/password-again password r00tme
# or encrypted using an MD5 hash, see grub-md5-crypt(8).
#d-i grub-installer/password-crypted password [MD5 hash]

# Use the following option to add additional boot parameters for the
# installed system (if supported by the bootloader installer).
# Note: options passed to the installer will be added automatically.
#d-i debian-installer/add-kernel-opts string nousb

### Finishing up the installation
# During installations from serial console, the regular virtual consoles
# (VT1-VT6) are normally disabled in /etc/inittab. Uncomment the next
# line to prevent this.
#d-i finish-install/keep-consoles boolean true

# Avoid that last message about the install being complete.
d-i finish-install/reboot_in_progress note

# This will prevent the installer from ejecting the CD during the reboot,
# which is useful in some situations.
#d-i cdrom-detect/eject boolean false

# This is how to make the installer shutdown when finished, but not
# reboot into the installed system.
#d-i debian-installer/exit/halt boolean true
# This will power off the machine instead of just halting it.
#d-i debian-installer/exit/poweroff boolean true

### Preseeding other packages
# Depending on what software you choose to install, or if things go wrong
# during the installation process, its possible that other questions may
# be asked. You can preseed those too, of course. To get a list of every
# possible question that could be asked during an install, do an
# installation, and then run these commands:
#   debconf-get-selections --installer > file
#   debconf-get-selections >> file


#### Advanced options
### Running custom commands during the installation
## i386 Preseed Example
# d-i preseeding is inherently not secure. Nothing in the installer checks
# for attempts at buffer overflows or other exploits of the values of a
# preconfiguration file like this one. Only use preconfiguration files from
# trusted locations! To drive that home, and because its generally useful,
# heres a way to run any shell command youd like inside the installer,
# automatically.

# This first command is run as early as possible, just after
# preseeding is read.
#d-i preseed/early_command string anna-install some-udeb
# This command is run immediately before the partitioner starts. It may be
# useful to apply dynamic partitioner preseeding that depends on the state
# of the disks (which may not be visible when preseed/early_command runs).
#d-i partman/early_command \
#       string debconf-set partman-auto/disk "$(list-devices disk | head -n1)"
# This command is run just before the install finishes, but when there is
# still a usable /target directory. You can chroot to /target and use it
# directly, or use the apt-install and in-target commands to easily install
# packages and run commands in the target system.
#d-i preseed/late_command string apt-install zsh; in-target chsh -s /bin/zsh
  ' | sudo tee -a "./preseed.cfg"
}

# Create CentOS Kickstart
function create_kickstart(){
  echo '# File: /mnt/public/Support/Platforms/CentOS8/centos8-ks.cfg
# Locations:
#    /mnt/public/Support/Platforms/CentOS8/centos8-ks.cfg
# Author: bgstack15
# Startdate: 2017-06-02
# Title: Kickstart for CentOS 8 for ipa.example.com
# Purpose: To provide an easy installation for VMs and other systems in the Mersey network
# History:
#    2017-06 I learned how to use kickstart files for the RHCSA EX-200 exam
#    2017-08-08 Added notifyemail to --extra-args
#    2017-10-29 major revision to use local repository
#
#
#
#
#    2019-09-24 fork for CentOS 8
# Usage with virt-install:
#    vm=c8-01a ; time sudo virt-install -n "${vm}" --memory 2048 --vcpus=1 --os-variant=centos7.0 --accelerate -v --disk path=/var/lib/libvirt/images/"${vm}".qcow2,size=20 -l /mnt/public/Support/SetupsBig/Linux/CentOS-8-x86_64-1905-dvd1.iso --initrd-inject=/mnt/public/Support/Platforms/CentOS8/centos8-ks.cfg --extra-args "ks=file:/centos8-ks.cfg SERVERNAME=${vm} NOTIFYEMAIL=bgstack15@gmail.com net.ifnames=0 biosdevname=0" --debug --network type=bridge,source=br0 --noautoconsole
#    vm=c8-01a; sudo virsh destroy "${vm}"; sudo virsh undefine --remove-all-storage "${vm}";
# Reference:
#    https://sysadmin.compxtreme.ro/automatically-set-the-hostname-during-kickstart-installation/
#    /mnt/public/Support/Platforms/CentOS7/install-vm.txt

#platform=x86, AMD64, or Intel EM64T
#version=DEVEL
# Install OS instead of upgrade
install
# Keyboard layouts
keyboard "us"
# Root password
rootpw --plaintext f0rg3tkickstart&
# my user
user --groups=wheel --name=centvm --password=$6$.gh9u7vg2HDJPPX/$g3X1l.q75fs7i0UKUt6h88bDIo1YSGGj/1DGeUzzbMTb0pBh4of6iNYWyxws/937qUiPgETqOsYFI5XNrkaUe. --iscrypted --gecos="centvm"

# System language
lang en_US.UTF-8
# Firewall configuration
firewall --enabled --ssh
# Reboot after installation
reboot
# Network information
#attempting to put it in the included ks file that accepts hostname from the virsh command.
#network  --bootproto=dhcp --device=eth0 --ipv6=auto --activate
%include /tmp/network.ks
# System timezone
timezone America/New_York --utc
# System authorization information
auth  --useshadow  --passalgo=sha512
# Use network installation instead of CDROM installation media
#url --url="http://www.ipa.example.com/mirror/centos/8/BaseOS/x86_64/os"

# Use text mode install
text
# SELinux configuration
selinux --permissive
# Do not configure the X Window System
skipx

# Use all local repositories
# Online repos
#repo --name=examplerpm --baseurl=http://www.ipa.example.com/example/repo/rpm/
#repo --name=base --baseurl=https://www.ipa.example.com/mirror/centos/$releasever/BaseOS/$basearch/os/
#repo --name=appstream --baseurl=https://www.ipa.example.com/mirror/centos/$releasever/AppStream/$basearch/os/
#repo --name=extras --baseurl=https://www.ipa.example.com/mirror/centos/$releasever/extras/$basearch/os/
#repo --name=powertools --baseurl=https://www.ipa.example.com/mirror/centos/$releasever/PowerTools/$basearch/os/
#repo --name=epel --baseurl=https://www.ipa.example.com/mirror/fedora/epel/$releasever/Everything/$basearch

# Offline repos
#
#
#
#
#

firstboot --disabled

# System bootloader configuration
bootloader --location=mbr
# Partition clearing information
clearpart --all --initlabel
# Disk partitioning information
autopart --type=lvm

%pre
echo "network  --bootproto=dhcp --device=eth0 --ipv6=auto --activate --hostname renameme.ipa.example.com" > /tmp/network.ks
for x in $( cat /proc/cmdline );
do
   case $x in
      SERVERNAME*)
         eval $x
         echo "network  --bootproto=dhcp --device=eth0 --ipv6=auto --activate --hostname ${SERVERNAME}.ipa.example.com" > /tmp/network.ks
         ;;
      NOTIFYEMAIL*)
         eval $x
         echo "${NOTIFYEMAIL}" > /mnt/sysroot/root/notifyemail.txt
  ;;
   esac
done
cp -p /run/install/repo/ca-ipa.example.com.crt /etc/pki/ca-trust/source/anchors/ 2>/dev/null || :
wget http://www.ipa.example.com/example/certs/ca-ipa.example.com.crt -O /etc/pki/ca-trust/source/anchors/ca-ipa.example-wget.com.crt || :
update-ca-trust || :
%end

%post
(
   # Set temporary hostname
   #hostnamectl set-hostname renameme.ipa.example.com;

   ifup eth0
   sed -i -r -e "s/ONBOOT=.*/ONBOOT=yes/;" /etc/sysconfig/network-scripts/ifcfg-e*

   # Get local mirror root ca certificate
   wget http://www.ipa.example.com/example/certs/ca-ipa.example.com.crt -O /etc/pki/ca-trust/source/anchors/ca-ipa.example.com.crt && update-ca-trust

   # Get local mirror repositories
   wget https://www.ipa.example.com/example/repo/rpm/examplerpm.repo -O /etc/yum.repos.d/examplerpm.repo;
   wget http://www.ipa.example.com/example/repo/rpm/examplerpm.mirrorlist -O /etc/yum.repos.d/examplerpm.mirrorlist
   distro=centos8 ; wget https://www.ipa.example.com/example/repo/mirror/example-bundle-${distro}.repo -O /etc/yum.repos.d/example-bundle-${distro}.repo && grep -oP "(?<=^\[).*(?=-example])" /etc/yum.repos.d/example-bundle-${distro}.repo | while read thisrepo; do yum-config-manager --disable "${thisrepo}"; done # NONE TO REMOVE dnf -y remove dnfdragora ; yum clean all ; yum update -y ; # Remove graphical boot and add serial console sed -i -r -e "/^GRUB_CMDLINE_LINUX=/{s/(\s*)(rhgb|quiet)\s*/\1/g;};" -e "/^GRUB_CMDLINE_LINUX=/{s/(\s*)\"$/ console=ttyS0 console=tty1\"/;}" /etc/default/grub grub2-mkconfig > /boot/grub2/grub.cfg

   # postfix is already started by default on centos8
   # Send IP address to myself
   thisip="$( ifconfig 2>/dev/null | awk "/Bcast|broadcast/{print $2}" | tr -cd "[^0-9\.\n]" | head -n1 )"
   {
      echo "${SERVER} has IP ${thisip}."
      echo "system finished kickstart at $( date "+%Y-%m-%d %T" )";
   } | /usr/share/bgscripts/send.sh -f "root@$( hostname --fqdn )" \
      -h -s "${SERVER} is ${thisip}" $( cat /root/notifyemail.txt 2>/dev/null )

   # No changes to graphical boot
   #

   # fix the mkhomedir problem
   systemctl enable oddjobd.service && systemctl start oddjobd.service

   # Personal customizations
   mkdir -p /mnt/bgstack15 /mnt/public
   su bgstack15-local -c "sudo /usr/share/bgconf/bgconf.py"

) >> /root/install.log 2>&1
%end

%packages
@core
@^minimal install
bc
bgconf
bgscripts-core
bind-utils
cifs-utils
cryptsetup
dosfstools
epel-release
expect
firewalld
git
iotop
ipa-client
-iwl*-firmware
mailx
man
mlocate
net-tools
nfs-utils
p7zip
parted
python3-policycoreutils
rpm-build
rsync
screen
strace
sysstat
tcpdump
telnet
vim
wget
yum-utils
%end
  ' | sudo tee -a "./kickstart.cfg"
}