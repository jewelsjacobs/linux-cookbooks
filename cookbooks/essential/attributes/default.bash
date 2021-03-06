#!/bin/bash -e

export APT_ESSENTIAL_PACKAGES=(
    'auditd'
    'bzip2'
    'curl'
    'dialog'
    'git'
    'hping3'
    'iptables'
    'libfontconfig'
    'libxml2-utils'
    'logrotate'
    'lsb-release'
    'lsof'
    'mtr-tiny'
    'net-tools'
    'netcat'
    'nmap'
    'rsync'
    'screen'
    'software-properties-common'
    'tree'
    'unzip'
    'w3m'
    'wget'
)

export RPM_ESSENTIAL_PACKAGES=(
    'audit'
    'bzip2'
    'curl'
    'dialog'
    'fontconfig'
    'git'
    'iptables'
    'libxml2'
    'logrotate'
    'lsof'
    'mtr'
    'nc'
    'nmap'
    'rsync'
    'screen'
    'tree'
    'unzip'
    'wget'
)