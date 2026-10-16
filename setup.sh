#!/bin/sh

# setup.sh
#
# Description:
#   マシンの初期セットアップを行います。
#   共通のセットアップ時に一度だけ実行します。
#
# Example:
#   su -c 'bash setup.sh'
#

cd /opt/host-scripts

# エラー時: 終了
set -eu

# ERROR: root権限がない
if [ "$(id -u)" -ne 0 ]; then
    echo "Run this script as root: su -c 'sh setup.sh'"
    return
fi

echo
echo
echo
echo "マシンの初期セットアップを行います。"
echo "このスクリプトはホストマシンの初回セットアップ時に一度だけ実行します。"
read -r -p "実行しますか？ (y/n): " answer
if [[ ! "$answer" =~ ^[yY]$ ]]; then
    exit
fi

# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
#  パッケージ情報更新
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
echo
echo
echo
echo "パッケージを更新します..."
sleep 5

apt update
apt upgrade -y
apt full-upgrade -y


# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
#  パッケージインストール
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
echo
echo
echo
echo "パッケージをインストールします..."
sleep 5

apt install -y \
    bash \
    bash-completion \
    ca-certificates \
    coreutils \
    curl \
    git \
    gnupg \
    openssh-server \
    rsync \
    sudo \
    ufw \
    unzip \
    vim \
    wireguard \
    wget


# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
#  Docker インストール
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
echo
echo
echo
echo "Dockerをインストールします..."
sleep 5

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

apt update
apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin


# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
#  パッケージ設定
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
git config --system init.defaultBranch main
git config --system core.editor vim


# Finish
