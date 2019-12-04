#!/bin/sh
# Global Variables
release="$(lsb_release -rs)"
codename="$(lsb_release -cs)"
id="$(lsb_release -is)"
pkglistX="chromium terminator tor-browser"
pkglistTCP="curl whois wget traceroute openvpn nmap links2 unzip ca-certificates"
pkglistcode="inxi git tmux neofetch htop ranger minicom gcc-8 make"
pkglistdockup="apt-transport-https ca-certificates curl gnupg2 software-properties-common"
pkglistdock="docker-ce docker-ce-cli containerd.io"
result="$?"

# Function Result
function res
    {
        if [ $result -eq 0 ];
            then echo "success";
        else echo "failure";
        fi
    }

# Fucntion Apt
function aptin
    {
        sudo apt-get -y install &>> ~/setup.log;
        res;
    }

function aptup
    {
        sudo apt-get update &>> ~/setup.log && sudo apt-get -y upgrade &>> ~/setup.log;
        res;
    }

function aptrm
    {
        sudo apt-get -y autoremove &>> ~/setup.log && sudo apt-get -y autoclean &>> ~/setup.log;
        res;
    }


# Funciton Debian
function dpkgad
    {
        sudo dpkg --add-architecture i386 &>> ~/setup.log;
        res;
    }

function aptadd
    {
        sudo printf "deb http://http.debian.net/debian unstable main" | sudo tee /etc/apt/sources.list.d/unstable.list &>> ~/setup.log;
        sudo printf '%s\n' "Package: *" "Pin: release=$codename" "Pin-Priority: 900" | sudo tee /etc/apt/preferences.d/$codename &>> ~/setup.log;
        sudo printf '%s\n' "Package: *" "Pin: release=unstable" "Pin-Priority: 1" | sudo tee /etc/apt/preferences.d/unstable &>> ~/setup.log;
        sudo printf '%s\n' "Package: *" "Pin release=multimedia" "Pin-Priority: 901" | sudo tee /etc/apt/preferences.d/multimedia &>> ~/setup.log;
        sudo printf "deb https://www.deb-multimedia.org $codename main non-free" | sudo tee /etc/apt/sources.list.d/multimedia.list &>> ~/setup.log;
        res;
    }

function multi
    {
        sudo apt-get update &>> ~/setup.log;
        sudo apt-get update -oAcquire::AllowInsecureRepositories=true &>> ~/setup.log;
        sudo apt-get -y install deb-multimedia-keyring -oAcquire::AllowInsecureRepositories=true &>> ~/setup.log;
        sudo apt-get -y dist-upgrade &>> ~/setup.log;
        res;
    }

# Function Devuan
function dockup
    {
        aptin $pkglistdock &>> ~/setup.log;
        curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - &>> ~/setup.log;
        sudo printf "deb [arch=amd64] https://download.docker.com/linux/debian buster stable | sudo tee /etc/apt/sources.list.d/docker.list &>> ~/setup.log;
        sudo usermod -a -G docker $USER &>> ~/setup.log;
        res;
    }

function devaptadd
    {
        sudo printf '%s\n' "deb http://deb.devuan.org/merged unstable main contrib non-free" "deb-src http://deb.devuan.org/devuan unstable main contrib non-free " | sudo tee /etc/apt/sources.list.d/unstable.list &>> ~/setup.log;
        sudo printf '%s\n' "Package: *" "Pin: release=unstable" "Pin-Priority: 2" | sudo tee /etc/apt/preferences.d/unstable &>> ~/setup.log;
        sudo printf '%s\n' "deb http://deb.devuan.org/merged experimental main contrib non-free" "deb-src http://deb.devuan.org/devuan experimental main contrib non-free" | sudo tee /etc/apt/sources.list.d/experimental.list &>> ~/setup.log;
        sudo printf '%s\n' "Package: *" "Pin:release=experimental" "Pin-Priority: 1" | sudo tee /etc/apt/preferences.d/experimental &>> ~/setup.log;
        res;
    }

# Function Git
function gitset
    {
        if [ ! -d "~/git" ];
            then
                mkdir ~/git;
                git clone https://github.com/zellkou/bash ~/git/bash &>> ~/setup.log;
                cp ~/git/bash/bash* ~/ &>> ~/setup.log;
                sudo cp ~/git/bashbash/* /root/ &>> ~/setup.log;
            else
                git clone https://github.com/zellkou/bash ~/git/bash &>> ~/setup.log;
                cp ~/git/bash/bash* ~/ &>> ~/setup.log;
                sudo cp ~/git/bash/bash* /root/ &>> ~/setup.log;
        fi
        res;
    }


# Function dnf
function dnfint
    {
        sudo dnf -y install &>> ~/setup.log;
        res;
    }

function dnfup
    {
        sudo dnf check update &>> ~/setup.log &&
        sudo dnf -y upgrade &>> ~/setup.log;
        res;
    }

function dnfrm
    {
        sudo dnf -y autoremove &>> ~/setup.log &&
        sudo dnf -y autoclean &>> ~/setup.log;
        res;
    }

# Function nordvpn
function nord
    {
        cd /etc/openvpn &>> ~/setup.log;
        sudo wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip &>> ~/setup.log;
        sudo unzip ovpn.zip &>> ~/setup.log;
        sudo rm ovpn.zip &>> ~/setup.log;
        cd ovpn_tcp &>> ~/setup.log;
        sudo find . -type f -name \*.ovpn -exec sed -i.bak "s|auth-user-pass|auth-user-pass ../auth.txt|g" {} + &>> ~/setup.log;
        cd ../ovpn_udp &>> ~/setup.log;
        sudo find . -type f -name \*.ovpn -exec sed -i.bak "s|auth-user-pass|auth-user-pass ../auth.txt|g" {} + &>> ~/setup.log;
        cd ../ &>> ~/setup.log;
        sudo touch auth.txt &>> ~/setup.log;
        echo "Input user for auth.txt";
        read user;
        sudo printf "$user" | sudo tee auth.txt;
        echo "Input passwd for auth.txt"
        read pass;
        sudo printf "$pass" | sudo tee auth.txt;
        cd ~/;
        res;
    }

# Fuck Dash
function fdas
    {
        sudo ln -sf /bin/bash /bin/sh &>> ~/setup.log;
        sudo ln -sf /bin/bash /bin/sh.distrib &>> ~/setup.log;
        sudo sed -i.bak "s|dash|bash|g" /var/dpkg/diversions &>> ~/setup.log;
        res;
    }

# Check EUID
if [[ $EUID != 0 ]]; then

# Check Distro
    if [[ $id == Debian ]]; then

# Debian
        if [[ -d "/etc/X11" ]]; then
            fdas;
            dpkgad;
            aptadd;
            multi;
            aptup;
            dockup;
            devaptadd;
            aptup;
            aptin $pkglistX $pkglistTCP $pkglistcode;
            aptin "-t unstable firefox";
            aptrm;
            gitset;
            nord;
            res;
            exit
        else
            fdas;
            aptup;
            dockup;
            devaptadd;
            aptup;
            aptin $pkglistTCP $pkglistcode;
            aptrm;
            gitset;
            nord;
            res;
            exit
        fi

# Devuan
    if [[ $id == Devuan ]]; then
        if [[ -d "/etc/X11" ]]; then
            fdas;
            aptup;
            aptin $pkglistX $pkglistTCP $pkglistcode;
            aptin "-t unstable firefox";
            aptrm;
            gitset;
            nord;
            res;
            exit
        else
            fdas;
            aptup;
            aptin; $pkglistTCP $pkglistcode;
            aptrm;
            gitset;
            nord
            res;
            exit
        fi

# Raspbian
    elif [[ $id == Raspbian ]]; then
        fdas;
        aptup;
        aptin $pkglistTCP $pkglistcode;
        aptrm;
        gitset;
        nord;
        res;
        exit

# Centos
    elif [[ $id == Centos ]]; then
        if [[ -d "/etc/X11" ]]; then
            dnfup;
            dnfint $pkglistX $pkglistTCP $pkglistcode;
            dnfrm;
            res;
            exit
        else
            dnfup;
            dnfint $pkglistTCP $pkglistcode;
            dnfrm;
            res;
            exit
        fi

# Fedora
    elif [[ $id == Fedora ]]; then
        dnfup;
        dnfint $pkglistX $pkglistTCP $pkglistcode;
        dnfrm;
        res;
        exit

# Ubuntu
    elif [[ $id == Ubuntu ]]; then
        echo "Please install a real version of linux and try again";

# Arch
    elif [[ $id == Arch ]]; then
        echo "If you are using Arch you can rewrite this yourself";

# Unsupported Distro
    else
        echo "Unsupported Distro";
    fi

# Set sudo first
else
    echo "Set up sudo first you lazy SOB";
fi
done
