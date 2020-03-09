#!/usr/bin/env bash
while :; do
    read -p ">" INPUT_SERVER_VERSION
    case $INPUT_SERVER_VERSION in
    1.7.10)
        JAR_URL="https://repo.akarinext.org/pub/paper/1.7/paperspigot-1.7.10-R0.1.jar"
        break
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
