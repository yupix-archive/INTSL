#!/bin/bash
while :; do
    read -p ">" INPUT_SERVER_VERSION
    case $INPUT_SERVER_VERSION in
    1.7.10) #対応予定有り
        echo "対応予定有り"
        #JAR_URL=""
        #break
        ;;
    1.8.8)
        JAR_URL="https://papermc.io/api/v1/paper/1.8.8/443/download"
        break
        ;;
    1.9.4)
        JAR_URL="https://papermc.io/api/v1/paper/1.9.4/773/download"
        break
        ;;
    1.10.2)
        JAR_URL="https://papermc.io/api/v1/paper/1.10.2/916/download"
        break
        ;;
    1.11.2)
        JAR_URL="https://papermc.io/api/v1/paper/1.11.2/1104/download"
        break
        ;;
    1.12.2)
        JAR_URL="https://papermc.io/api/v1/paper/1.12.2/1618/download"
        break
        ;;
    1.13.2)
        JAR_URL="https://papermc.io/api/v1/paper/1.13.2/655/download"
        break
        ;;
    1.14.4)
        JAR_URL="https://papermc.io/api/v1/paper/1.14.4/243/download"
        break
        ;;
    1.15.2)
        JAR_URL="https://papermc.io/api/v1/paper/1.15.2/112/download"
        break
        ;;

    *)
        echo "変な数値打たないで"
        ;;
    esac
done
