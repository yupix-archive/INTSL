#!/bin/bash
for ((i = 0; i < ${#chars}; i++)); do
    sleep 0.1
    echo -en "${chars:$i:1} ファイルの確認中 " "\r"
done
mc_donwload_version="1.7.8"
if [ ! -e $SERVER_JARLIST_PATH\server$mc_donwload_version.jar ]; then
    echo "jarファイルが存在しません!ファイルをダウンロードしますか?"
    echo "使用可能 (Y)es or (N)o "
    while :; do
        read -p ">" INPUT_Y_OR_N
        case $INPUT_Y_OR_N in
        [yY]*)
            SPINNER_FILEDOWNLOAD
            wget -q https://launcher.mojang.com/v1/objects/c69ebfb84c2577661770371c4accdd5f87b8b21d/server.jar -O $SERVER_JARLIST_PATH\server$mc_donwload_version.jar
            SPINNER_FILECHECK
            if [ -e $SERVER_JARLIST_PATH\server$mc_donwload_version.jar ]; then
                JARDOWNLOADSUCCESS
                break
            else
                FILEDOWNLOADFAILEDMESSEAGE
            fi
            ;;
        [nN]*)
            DONWLOAD_CANCELLATION
            ;;
        *)
            echo "(Y)esまたは(N)oを入力してください"
            ;;
        esac
    done
else
    echo "JARファイルが存在します"
fi
