#!/bin/bash

set -eo pipefail

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Oneline
# @raycast.mode compact
# @raycast.refreshTime 5s

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "optional": true, "placeholder": "go | rust | python"}
# @raycast.argument2 { "type": "text", "optional": true, "placeholder": "rebuild: true | false"}

# Documentation:
# @raycast.author sfwn
# @raycast.authorURL https://github.com/sfwn

# 获取脚本的绝对路径
SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
cd "$SCRIPTPATH" || exit

# get different language version through $1
lang=$1

# default use lang=go
if [ -z "$lang" ]; then
    lang="go"
fi

# check whether need force rebuild bin
rebuild=$2
# default not force rebuild
if [ -z "$rebuild" ]; then
    rebuild="false"
fi

# define a variable to store bin path
bin=""

# switch lang
case $lang in
    go)
        # check ./oneline/${lang}/bin is available
        bin="./internal/oneline/${lang}/bin"
        # if not available or need force rebuild
        if [[ ! -f "$bin" || "$rebuild" == "true" ]]; then
            echo "lang=$lang, rebuild=$rebuild, building..."
            cd ./internal/oneline/${lang} && go build -o ./bin *.go
        fi
        ;;
    rust)
        bin="./internal/oneline/${lang}/bin"
        if [[ ! -f "$bin" || "$rebuild" == "true" ]]; then
            echo "lang=$lang, rebuild=$rebuild, building..."
            cd ./internal/oneline/${lang} && cargo build --release && cp ./target/release/oneline ./bin
        fi
        ;;
    *)
        echo "not implemented yet: $lang"
        exit 1
        ;;
esac

# cd to root dir
cd "$SCRIPTPATH" || exit

VALUE=$("$bin")
echo -n $VALUE | pbcopy

echo $VALUE
