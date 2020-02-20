#!/bin/bash
mc_donwload_version="$INPUT_SERVER_VERSION"
PROGRESS_STATUS="ファイルの確認中"
SPINNER
if [ -e ${SERVER_PAPERLIST_PATH}paperserver$mc_donwload_version.jar ]; then
    echo "JARファイルが存在します"
    SERVER_CREATE
else
    echo "jarファイルが存在しません!ファイルをダウンロードしますか?"
    echo "使用可能 (Y)es or (N)o default(Yes)"
    while :; do
        if [[ -e $SERVER_PAPERLIST_PATH\paperserver$mc_donwload_version.jar ]]; then
            echo "JARファイルが存在します"
            break
            SERVER_CREATE
        else
            read -p ">" INPUT_Y_OR_N
            INPUT_Y_OR_N=${INPUT_Y_OR_N:-y}
            case $INPUT_Y_OR_N in
            [yY]*)
                while :; do
                    PROGRESS_STATUS="ファイルのダウンロード中"
                    SPINNER
                    if [ -e ${SERVER_PAPERLIST_PATH}paperserver$mc_donwload_version.jar ]; then
                        echo "ファイルのダウンロードに成功しました。"
                        SERVER_CREATE
                    else
                        if [[ $wgetpid != 0 ]]; then
                            wget -q $JAR_URL -O ${SERVER_PAPERLIST_PATH}paperserver$mc_donwload_version.jar &
                            pid=$wgetpid
                            count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
                            RETRYCOUNT=$((RETRYCOUNT + 1))
                        fi
                    fi
                done
                ;;
            [nN]*)
                DONWLOAD_CANCELLATION
                ;;
            *)
                echo "(Y)esまたは(N)oを入力してください"
                ;;
            esac
        fi
    done
fi
