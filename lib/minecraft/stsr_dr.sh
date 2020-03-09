#!/usr/bin/env bash
BUILD() {
    if [[ -e BuildTools.jar ]]; then
        if [[ -e BuildTools.log.txt ]];then
            rm -r BuildTools.log.txt
        fi
        #java -jar BuildTools.jar --rev $buildversion
        echo "SCREENNAME: $PWGEN"
        sleep 5
        screen -AdmS $PWGEN java -jar BuildTools.jar --rev $buildversion nogui
        while [[ $buildstatus != "Success! Everything completed successfully. Copying final .jar files now." ]]; do
            #更新
            buildstatus=$(cat ./BuildTools.log.txt | grep "Success! Everything completed successfully. Copying final .jar files now.")
            #現状
            PROGRESS_STATUS="BUILD NOW                 "
            SPINNER
            #screen -r grep $PWGEN | "Success! Everything completed successfully. Copying final .jar files now."
        done
        echo -e "\e[1;37;32mBUILD SUCCESS\e[0m             "
        cd -
        if [[ ! -e ./minecraft/versionlist ]]; then
            mkdir ./minecraft/versionlist
        fi
        if [[ ! -e ./minecraft/versionlist/spigot ]]; then
            mkdir ./minecraft/versionlist/spigot/
        fi
        mv ./build/spigot/spigot-$buildversion.jar ./minecraft/versionlist/spigot/
        SERVER_CREATE
    fi
}

#元々そのバージョンのJARがあるかチェック
if [[ -e ./minecraft/versionlist/spigot/spigot-$buildversion.jar ]]; then
    echo "JARファイルが存在します。"
    SERVER_CREATE
fi

mc_donwload_version="$INPUT_SERVER_VERSION"
buildtools_url="https://hub.spigotmc.org/jenkins/job/BuildTools/111/artifact/target/BuildTools.jar"
PROGRESS_STATUS="ファイルの確認中"
PWGEN=$(pwgen)

SPINNER
if [[ ! -e ./lib/BuildTools.jar ]]; then
    #BuildToolsのダウンロード
    wget $buildtools_url -P ./lib/
#-P ./output/build/spigot/$mc_donwload_version
fi
if [[ ! -e ./minecraft/spigot/spigotserver$INPUT_SERVER_VERSION ]]; then
    if [[ ! -e ./build ]]; then
        echo "ファイルが存在しないよー1"
        mkdir build
    fi
    if [[ ! -e ./build/spigot ]]; then
        echo "ファイルが存在しないよー"
        mkdir ./build/spigot
    fi
    #削除予定
    #cp ./lib/BuildTools.jar ./build/spigot
    cd ./build/spigot/
    while :; do
        FILECOUNT=$(ls -1 | wc -l)
        PROGRESS_STATUS="ファイルの確認中...       "
        SPINNER
        if [[ $FILECOUNT = 0 ]]; then
            if [[ $FILECLEARCHECK = y ]]; then
                PROGRESS_STATUS="実行環境の削除に成功...   "
                SPINNER
            fi
            PROGRESS_STATUS="BUILDを開始します...      "
            SPINNER
            break
            #削除予定
            #        elif [[ $FILECOUNT = 1 ]]; then
            #            if [[ -e BuildTools.jar ]]; then
            #                echo "テスト"
            #                break
            #            fi
            #            PROGRESS_STATUS="前回の実行環境の削除を開始"
            #            SPINNER
            #            rm -rf *
            #            FILECLEARCHECK="y"
        else
            if [[ $setting_resetspigot = y ]]; then
                PROGRESS_STATUS="前回の実行環境の削除を開始"
                SPINNER
                rm -rf *
                FILECLEARCHECK="y"
            else
                break
            fi
        fi
    done
    cd -
    cp ./lib/BuildTools.jar ./build/spigot
    cd ./build/spigot/
    FILECOUNT=$(ls -1 | wc -l)
    if [[ $setting_resetspigot = y ]]; then
        while [ $FILECOUNT -le 1 ]; do
            BUILD
        done
    elif [[ $setting_resetspigot = n ]]; then
        while :; do
            BUILD
        done
    fi
fi
