#!/bin/sh

# update.sh
#
# Description:
#   スクリプトとパッケージの更新を行います。
#
# Example:
#   su -c 'bash update.sh'
#

cd /opt/host-scripts

# エラー時: 終了
set -eu

echo
echo
echo
echo "スクリプトとパッケージの更新を行います。"
read -r -p "実行しますか？ (y/n): " answer
if [[ ! "$answer" =~ ^[yY]$ ]]; then
    exit
fi

# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
#  パッケージ更新
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
echo
echo
echo
echo "パッケージを更新します..."
sleep 5

apt update
apt upgrade -y


# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
#  スクリプト更新
# -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- #
echo
echo
echo
echo "スクリプトを更新します..."
sleep 5

git pull


# Finish
