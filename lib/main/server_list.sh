#!/usr/bin/env bash
if [[ -z $serverstartlist ]];then
    echo "管理するサーバーのコマンドを入力してください"
    read -p ">" serverstartlist
fi
case $serverstartlist in
#STARTSERVERLIST






#ENDSERVERLIST
*)
    #不正なキー入力
    echo "上記に出ているコマンドを入力してください。"
    ;;
esac
