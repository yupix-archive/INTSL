#!/bin/bash
while :; do
    read -p ">" INPUT_SERVER_VERSION
    case $INPUT_SERVER_VERSION in
    1.7.10)
        chmod 755 ./lib/minecraft/officialserverlist/v1.7.10.sh
        . ./lib/minecraft/officialserverlist/v1.7.10.sh
        SERVER_CREATE
        ;;
    1.8.8)
        chmod 755 ./lib/minecraft/officialserverlist/v1.8.8.sh
        . ./lib/minecraft/officialserverlist/v1.8.8.sh
        SERVER_CREATE
        ;;
    1.9.4)
        chmod 755 ./lib/minecraft/officialserverlist/v1.9.4.sh
        . ./lib/minecraft/officialserverlist/v1.9.4.sh
        SERVER_CREATE
        ;;
    1.10.2)
        chmod 755 ./lib/minecraft/officialserverlist/v1.10.2.sh
        . ./lib/minecraft/officialserverlist/v1.10.2.sh
        SERVER_CREATE
        ;;
    1.11.2)
        chmod 755 ./lib/minecraft/officialserverlist/v1.11.2.sh
        . ./lib/minecraft/officialserverlist/v1.11.2.sh
        SERVER_CREATE
        ;;
    1.12.2)
        chmod 755 ./lib/minecraft/officialserverlist/v1.12.2.sh
        . ./lib/minecraft/officialserverlist/v1.12.2.sh
        SERVER_CREATE
        ;;
    1.13.2)
        chmod 755 ./lib/minecraft/officialserverlist/v1.13.2.sh
        . ./lib/minecraft/officialserverlist/v1.13.2.sh
        SERVER_CREATE
        ;;
    1.14.4)
        chmod 755 ./lib/minecraft/officialserverlist/v1.14.4.sh
        . ./lib/minecraft/officialserverlist/v1.14.4.sh
        SERVER_CREATE
        ;;
    1.15.2)
        chmod 755 ./lib/minecraft/paperserverlist/v1.15.2.sh
        . ./lib/minecraft/officialserverlist/v1.15.2.sh
        SERVER_CREATE
        ;;

    *)
        echo "変な数値打たないで"
        ;;
    esac
done
