#!/usr/bin/env bash
FILECREATE() {
    while :; do
        PROGRESS_STATUS="ファイルの作成中"
        SPINNER
        if [[ $RETRYCOUNT -le $RETRYMAX ]]; then
            if [[ -e $FILENAME ]]; then
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
        if [ -e $EEW_SYSTEM_FILE ]; then
            PROGRESS_STATUS="SYSTEMファイルの確認に成功! 2/3"
            SPINNER
        else
            echo -e "\e[31mERROR\e[m: SYSTEMファイルの確認に失敗 2/3"
            FILENAME="./discord/eew"
            FILECREATE
        fi
        #jarファイルがあるかチェック
        PROGRESS_STATUS="SYSTEMファイルの確認中... 3/3     "
        SPINNER
        if [ -e $JAR ]; then
            PROGRESS_STATUS="SYSTEMファイルの確認に成功 3/3"
            SPINNER
            echo "全てのファイルの確認に成功しました"
            chmod +x ./discord/eew/eewbot-$EEW_VERSION.jar &
            cd $EEWFILE
            if [[ -e config.json ]];then
                TOKEN_EMPTY_CHECK=$(cat config.json | grep -Eo \"token\":\"\")
                if [[ $TOKEN_EMPTY_CHECK = \"token\":\"\" ]];then
                    echo "tokenを入力してね"
                    read INPUT_TOKEN_DATA
                    sed -i -e 's/"token":""/\"token\":"'$INPUT_TOKEN_DATA'"/' config.json
                fi
            fi
            java -jar eewbot-$EEW_VERSION.jar &
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
                    java -jar eewbot-$EEW_VERSION.jar &
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
                            chmod +x ./discord/eew/eewbot-$EEW_VERSION.jar &
                            break
                        else
                            PROGRESS_STATUS="ファイルのダウンロード中"
                            Formal_V=$(echo "$EEW_VERSION" | sed -e 's/\(.\)/\1./'g | sed -e 's/.$//')
                            if [[ $COUNT != 1 ]]; then
                                COUNT=$((COUNT + 1))
                                wget -q https://github.com/Team-Fruit/EEWBot/releases/download/$Formal_V/eewbot-$Formal_V.jar -O ./discord/eew/eewbot-$EEW_VERSION.jar &
                            fi
                            PROGRESS_STATUS="ファイルの確認中"
                        fi
                    done
                    #実行権限付与
                    chmod +x ./discord/eew/eewbot-$EEW_VERSION.jar &
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

echo "■ start   | EEWBotをスタートします"
read -p ">" INPUT
case $INPUT in
start)
    newbotstart
    ;;
vcheck)
    . ./assets/variable.txt
    echo "EEWBotにアップデートが存在するか確認します。"
    geturl=$(curl -s https://github.com/Team-Fruit/EEWBot/releases/latest | grep -Eo "http(s?)://(\w|:|%|#|\$|&|\?|\(|\)|~|\.|=|\+|\-|/)+")
    getversion=$(echo "${geturl}" | sed 's/https\:\/\/github.com\/Team-Fruit\/EEWBot\/releases\/tag\///g')
    EEW_GET_V=$(echo "VERSION $getversion" sed -e 's/[.]//g' | sed -e 's/[^0-9]//g')
    Formal_V=$(echo "$EEW_GET_V" | sed -e 's/\(.\)/\1./'g | sed -e 's/.$//')
    echo "    $getversion"
    if [[ $EEW_GET_V -gt $EEW_VERSION ]]; then
        echo "最新バージョンが存在します。 $EEW_GET_V"
        while [[ ! -e ./discord/eew/eewbot-$Formal_V.jar ]]; do
            PROGRESS_STATUS="ダウンロード中"
            SPINNER
            if [[ $COUNT != 1 ]]; then
                COUNT=$((COUNT + 1))
                wget -q "https://github.com/Team-Fruit/EEWBot/releases/download/$Formal_V/eewbot-$Formal_V.jar" -P ./discord/eew &
            fi
        done
        sed -i -e 's/EEW_VERSION="'$EEW_VERSION'"/EEW_VERSION="'$EEW_GET_V'"/' ./assets/variable.txt
        . ./assets/variable.txt
        if [[ $EEW_VERSION = $EEW_GET_V ]]; then
            echo "アップデートに成功しました。"
        else
            echo "アップデートに失敗しました。"
        fi
    else
        echo "最新バージョンだよ"
    fi
    ;;
esac
