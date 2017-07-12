#!/bin/bash

minimal_apt_get_install='apt-get install -y --no-install-recommends'
build_directory='/base_build'

## Enable Ubuntu Universe, Multiverse, and deb-src for main.
sed -i 's/^#\s*\(deb.*main restricted\)$/\1/g' /etc/apt/sources.list
sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list
sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list

## disable apt installing locales other than en
echo "path-exclude=/usr/share/locale/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc
echo "path-include=/usr/share/locale/en" >> /etc/dpkg/dpkg.cfg.d/01_nodoc

## overwrite the supported locales with just us english
mkdir -p /var/lib/locales/supported.d/
echo "en_US.UTF-8 UTF-8" > /var/lib/locales/supported.d/en

# Drop all manuals
echo "path-exclude=/usr/share/man/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc

# Drop all docs
echo "path-exclude=/usr/share/doc/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc
echo "path-include=/usr/share/doc/*/copyright" >> /etc/dpkg/dpkg.cfg.d/01_nodoc
echo "path-exclude=/usr/share/lintian/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc
echo "path-exclude=/usr/share/linda/*" >> /etc/dpkg/dpkg.cfg.d/01_nodoc

# delete doc except copyright files
rm -rf /usr/share/doc
rm -rf /usr/share/man
rm -rf /usr/share/locale

## APT
apt-get update
$minimal_apt_get_install apt-utils
## Install HTTPS support for APT.
$minimal_apt_get_install apt-transport-https ca-certificates

## Upgrade all packages.
apt-get dist-upgrade -y --no-install-recommends -o Dpkg::Options::="--force-confold"

## locales
$minimal_apt_get_install language-pack-en
locale-gen en_US
update-locale LANG=en_US.UTF-8 LC_CTYPE=en_US.UTF-8

## runit
$minimal_apt_get_install runit
cp $build_directory/runtime_scripts/start-runit.sh /start-runit.sh

## SSH
$minimal_apt_get_install openssh-server
mkdir -p /var/run/sshd
mkdir -p /etc/service/sshd
cp $build_directory/runtime_scripts/sshd.runit /etc/service/sshd/run



