#!/usr/bin/env bash
FILECREATE() {
    while :; do
        PROGRESS_STATUS="ファイルの作成中"
        SPINNER
        if [[ $RETRYCOUNT -le $RETRYMAX ]]; then
            if [[ -e $SYSTEMFILE ]]; then
                echo "ファイルの作成に成功"
                break
            else
                mkdir "$FILENAME"
                RETRYCOUNT=$((RETRYCOUNT + 1))
            fi
        else
            echo "リトライの最大値に達した為、自動で停止しました。"
            echo "もう一度実行し、同じエラーが発生する際は開発者に連絡をください。"
            #時間に名前を変えるため、コメントアウト
            #ERROR_VARIABLE=$(pwgen)
            #ERROR_REPORT=$(echo "ファイルの権限等が不足している可能性があります。" >>./errors/$ERROR_VARIABLE)
            exit 1
        fi
    done
}
newbotstart() {
    while :; do
        #discordファイルが存在するかチェック
        PROGRESS_STATUS="SYSTEMファイルの確認中... 1/3"
        SPINNER
        if [ -e $SYSTEMFILE ]; then
            PROGRESS_STATUS="SYSTEMファイルの確認に成功 1/3"
            SPINNER
        else
            echo -e "\e[31mERROR\e[m: SYSTEMファイルの確認に失敗 1/3"
            FILENAME="./discord"
            FILECREATE
        fi
        #musicファイルが存在するかチェック
        PROGRESS_STATUS="SYSTEMファイルの確認中... 2/3     "
        SPINNER
        if [ -e $SYSTEMFILEMUSIC ]; then
            PROGRESS_STATUS="SYSTEMファイルの確認に成功! 2/3"
            SPINNER
        else
            echo -e "\e[31mERROR\e[m: SYSTEMファイルの確認に失敗 2/3"
            FILENAME="./discord/jmusic"
            FILECREATE
        fi
        #jarファイルがあるかチェック
        PROGRESS_STATUS="SYSTEMファイルの確認中... 3/3     "
        SPINNER
        if [ -e $JAR ]; then
            PROGRESS_STATUS="SYSTEMファイルの確認に成功 3/3"
            SPINNER
            echo "全てのファイルの確認に成功しました"
            chmod +x ./discord/jmusic/JMusicBot-$JMUSIC_VERSION-$EDITION.jar &
            cd $FILE
            java -jar JMusicBot-$JMUSIC_VERSION-$EDITION.jar &
            count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
            while :; do
                pid=$!
                count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
                #暫定的(?)
                if [[ $count -le 1 ]]; then
                    PROGRESS_STATUS="system starting...."
                    SPINNER
                    break
                elif [[ $count -ge 2 ]]; then
                    kill $pid
                else
                    PROGRESS_STATUS="system starting...."
                    SPINNER
                    java -jar JMusicBot-$JMUSIC_VERSION-$EDITION.jar &
                fi
            done
            echo -e 'BOTSTATUS: \e[1;37;32mONLINE\e[0m'
            echo "exitでサービスを終了します。"
            while :; do
                read -p ">" SERVICEEXIT
                case "$SERVICEEXIT" in
                exit)
                    pid=$!
                    kill $pid
                    echo "$SERVICECHECK"
                    sleep 2
                    while :; do
                        count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
                        PROGRESS_STATUS="サービスの生存を確認中"
                        SPINNER
                        if [[ $RETRYCOUNT -le $RETRYMAX ]]; then
                            if [[ $count = 0 ]]; then
                                PROGRESS_STATUS="サービスのkillに成功"
                                SPINNER
                                echo "サービスを終了します..."
                                exit
                            else
                                PROGRESS_STATUS="サービスのkillに失敗"
                                SPINNER
                                RETRYCOUNT=$((RETRYCOUNT + 1))
                            fi
                        else
                            echo "リトライの最大値に達した為、自動で停止しました。"
                            echo "再度 "$SERVICEEXIT" を打ち、このエラーが発生する場合は開発者に報告を宜しくおねがいします。"
                            break
                        fi
                    done
                    ;;
                *)
                    #起動した際の終了コマンド等以外を入力した際の処理
                    echo "e以外の入力は受け付けていません"
                    ;;
                esac
            done
        else
            echo -e "\e[31mERROR\e[m: SYSTEMファイルの確認に失敗 3/3"
            echo "ファイルをダウンロードしますか? (使用可能: (Y)es or (N)o"
            while [ ! -e $JAR ]; do
                read -p ">" INPUT_DATA
                case $INPUT_DATA in
                [yY])
                    while [[ $progress_status != SUCCESS ]]; do
                        PROGRESS_STATUS="ファイルの確認中"
                        SPINNER
                        if [ -e $JAR ]; then
                            echo "ダウンロードに成功しました。"
                            #実行権限付与(暫定的)
                            chmod +x ./discord/jmusic/JMusicBot-$JMUSIC_VERSION-$EDITION.jar &
                            break
                        else
                            PROGRESS_STATUS="ファイルのダウンロード中"
                            Formal_V=$(echo "$JMUSIC_VERSION" | sed -e 's/\(.\)/\1./'g | sed -e 's/.$//')
                            if [[ $COUNT != 1 ]]; then
                                COUNT=$((COUNT + 1))
                                wget -q https://github.com/jagrosh/MusicBot/releases/download/$Formal_V/JMusicBot-$Formal_V-$EDITION.jar -O ./discord/jmusic/JMusicBot-$JMUSIC_VERSION-$EDITION.jar &
                            fi
                            PROGRESS_STATUS="ファイルの確認中"
                            #実行権限付与
                            chmod +x ./discord/jmusic/JMusicBot-$JMUSIC_VERSION-$EDITION.jar &
                        fi
                    done
                    ;;
                [nN])
                    echo "キャンセルしました。"
                    echo "サービスを終了します。"
                    exit 0
                    ;;
                *)
                    echo "(Y)es or (N)o で入力してください"
                    ;;
                esac
            done
        fi
    done
}

echo "■ start   | JmusiBotをスタートします"
read -p ">" INPUT
case $INPUT in
start)
    newbotstart
    ;;
vcheck)
    . ./assets/variable.txt
    echo "JmusicBotにアップデートが存在するか確認します。"
    geturl=$(curl -s https://github.com/jagrosh/MusicBot/releases/latest | grep -oE 'http(s?)://[0-9a-zA-Z?=#+_&:/.%]+')
    getversion=$(echo "${geturl}" | sed 's/https\:\/\/github.com\/jagrosh\/MusicBot\/releases\/tag\/v//g')
    JMUSIC_GET_V=$(echo "VERSION $getversion" sed -e 's/[.]//g' | sed -e 's/[^0-9]//g')
    Formal_V=$(echo "$JMUSIC_GET_V" | sed -e 's/\(.\)/\1./'g | sed -e 's/.$//')
    if [[ $JMUSIC_GET_V -gt $JMUSIC_VERSION ]]; then
        echo "最新バージョンがあるよ $JMUSIC_GET_V"
        while [[ ! -e ./discord/jmusic/JMusicBot-$Formal_V-Linux.jar ]]; do
            PROGRESS_STATUS="ダウンロード中"
            SPINNER
            if [[ $COUNT != 1 ]]; then
                COUNT=$((COUNT + 1))
                wget -q "https://github.com/jagrosh/MusicBot/releases/download/$Formal_V/JMusicBot-$Formal_V-$EDITION.jar" -P ./discord/jmusic &
            fi
        done
        sed -i -e 's/JMUSIC_VERSION="'$JMUSIC_VERSION'"/JMUSIC_VERSION="'$JMUSIC_GET_V'"/' ./assets/variable.txt
        . ./assets/variable.txt
        if [[ $JMUSIC_VERSION = $JMUSIC_GET_V ]]; then
            echo "アップデートに成功しました。"
        else
            echo "アップデートに失敗しました。"
        fi
    else
        echo "最新バージョンだよ"
    fi
    ;;
esac
