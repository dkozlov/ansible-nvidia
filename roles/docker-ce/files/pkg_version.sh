#!/usr/bin/env bash

set -e

log::error() {
    echo $@
}

log::fatal() {
    log::error $@
    exit 1
}

usage() {
    echo "Usage: $0 <package name> <package version>"
    exit 1
}

if [[ "$#" != 2 ]]; then
    usage
fi

pkg="$1"
version="$2"

yum_version_str() {
    local app=$1
    local v=$2
    local v_str=""

    if [[ -z "$2" || "$2" == "latest" ]]; then
        v_str=$(yum --showduplicates list ${app} | grep ${app} | sort -r | head -1 | awk '{ print $2 }')
    else
        v_str=$(yum --showduplicates list ${app} | grep ${app} | grep ${v} | sort -r | head -1 | awk '{ print $2 }')
    fi

    echo $v_str
}

apt_version_str() {
    local app=$1
    local v=$2
    local v_str=""

    if [[ -z "$2" || "$2" == "latest" ]]; then
        v_str=$(apt-cache madison ${app} | grep ${app} | sort -r | head -1 | awk '{ print $3 }')
    else
        v_str=$(apt-cache madison ${app} | grep ${app} | grep ${v} | sort -r | head -1 | awk '{ print $3 }')
    fi

    echo $v_str
}

# determining the package management sofware
pkgmgr=
# apt-get
if which apt-get >/dev/null 2>&1; then
    pkgmgr="apt-get"
# yum
elif which yum >/dev/null 2>&1; then
    pkgmgr="yum"
# Homebrew
elif which brew > /dev/null 2>&1; then
    pkgmgr="brew"
# no package management software found
else
    log::fatal "Can not determine the package manager software"
fi

version_str=""
case $pkgmgr in
    apt-get)
        version_str=$(apt_version_str "$pkg" "$version")
        ;;
    yum)
        version_str=$(yum_version_str "$pkg" "$version")
        ;;
    *)
        log::fatal "Can not determine the package manager software"
        ;;
esac

echo $version_str
