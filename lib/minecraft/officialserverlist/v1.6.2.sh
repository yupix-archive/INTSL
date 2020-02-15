#!/bin/bash
for ((i = 0; i < ${#chars}; i++)); do
    sleep 0.1
    echo -en "${chars:$i:1} ファイルの確認中 " "\r"
done
mc_donwload_version="1.6.2"
if [ ! -e $SERVER_JARLIST_PATH\server$mc_donwload_version.jar ]; then
    echo "jarファイルが存在しません!ファイルをダウンロードしますか?"
    echo "使用可能 (Y)es or (N)o "
    while :; do
        read -p ">" INPUT_Y_OR_N
        case $INPUT_Y_OR_N in
        [yY]*)
            SPINNER_FILEDOWNLOAD
            wget -q https://launcher.mojang.com/v1/objects/01b6ea555c6978e6713e2a2dfd7fe19b1449ca54/server.jar -O $SERVER_JARLIST_PATH\server$mc_donwload_version.jar
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
