# ホストマシンセットアップ用スクリプト

ホストマシン管理用のスクリプト集です。

## セットアップ（ワンライナー）

子のリポジトリをクローンし `setup.sh` を実行します。

```sh
su -c 'cd /opt && apt-get update && apt-get install -y bash git && git clone -o github "https://github.com/atrangel/host-scripts.git" && bash ./host-scripts/setup.sh'
```
