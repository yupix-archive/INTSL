#!/bin/bash
#------------------------------------------------------------------------------#
#外部ファイル読み込み
. ./assets/outdata.txt
. ./assets/language/ja.txt
. ./assets/permissions.txt
. ./assets/commands.txt
. ./assets/variable.txt
. ./assets/settings.txt
. ./newversion.txt
. ./version.txt
. ./version.txt
. ./assets/userdata/allsettings.txt
. ./assets/password.txt
#------------------------------------------------------------------------------#
target="$FILE/config.txt"
output=$3
outputdata="./assets/outdata.txt"
SELF_DIR_PATH=$(
    cd $(dirname $0)
    pwd
)/
OUTDATE="$SELF_DIR_PATH/assets/"

#今回から追加
#official
SERVER_JARLIST_PATH="./minecraft/versionlist/official/"
#paper
SERVER_PAPERLIST_PATH="./minecraft/versionlist/paper/"
#------------------------------------------------------------------------------#
##========================================##
##██╗███╗   ██╗████████╗███████╗██╗      ##
##██║████╗  ██║╚══██╔══╝██╔════╝██║
##██║██╔██╗ ██║   ██║   ███████╗██║
##██║██║╚██╗██║   ██║   ╚════██║██║      ##"
##██║██║ ╚████║   ██║   ███████║███████╗ ##"
##╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚══════╝
##========================================##

#このファイルを変更するにはShellScriptに詳しい方を知り合いにお持ちか、
#又はある程度の知識があることを前提に変更することをとても強く推奨します。
#本ファイルはMAIN SYSTEM そのもののため、どこかが欠けたりすると
#ほぼ確実に全ての機能が正常に動作しなくなります。
#本Projectの内容を変更する際は以下の本Projectの作者であるyupixが
#解説しているサイトを読みながらすることを推奨します。
# https://akari.fiid.net/dev/amb/top
#------------------------------------------------------------------------------#

#コマンド

firststart() {
    if [ $firststart = 0 ]; then
        echo "AMBPROJECTをインストールしていただきありがとうございます。"
        echo "本Projectを自分好みに動かすために初期設定を行うことを推奨します"
        echo "使用可能 (y)es (n)o"
        while :; do
            read INPUT_DATA
            if [ $INPUT_DATA = y ]; then
                sed -i -e 's/firststart="'$firststart'"/firststart="'1'"/' ./assets/settings.txt
                echo "#BOTを起動した際にVercheckを走らせるかどうか (default = yes)"
                read firstsetting1
                sed -i -e 's/setting_VersionCheck="'$setting_VersionCheck'"/setting_VersionCheck="'$firstsetting1'"/' ./assets/settings.txt
                echo "BOTを起動した際に招待リンクを表示するかどうか (default = yes)"
                read firstsetting2
                sed -i -e 's/setting_botinvite="'$setting_botinvite'"/setting_botinvite="'$firstsetting2'"/' ./assets/settings.txt
                echo "BOTを起動した際にTOKEN等の情報を更新するかどうか (default = yes)"
                read firstsetting3
                sed -i -e 's/setting_outputdata="'$setting_outputdata'"/setting_outputdata="'$firstsetting3'"/' ./assets/settings.txt
                echo "バックアップを行うか否か (default = yes)"
                read firstsetting4
                sed -i -e 's/setting_backuptime="'$setting_backuptime'"/setting_backuptime="'$firstsetting4'"/' ./assets/settings.txt
                echo "これで初期設定は終わりです、お疲れ様でした。"
                echo "この他にもExtension等様々な物の有効化方法が有りますが、詳しくは https://akari.fiid.net/dev/amb/top をご覧ください!"
                echo "それでは良いDiscordBotライフを!"
                sleep 10
                break
            elif [ $INPUT_DATA = n ]; then
                sed -i -e 's/firststart="'$firststart'"/firststart="'1'"/' ./assets/settings.txt
                echo "キャンセルしました!"
                echo "自動的に元の動作を行います。"
                break
            else
                echo "(y)es or (n)o を入力してください"
            fi
        done

    fi
}

main() {
    rm -r ./assets/outdata.txt
    sleep 1
    echo "$FAILEDELETENOW"
    echo "ファイルが削除できているか確認しています..."
    if [ -e $outputdata ]; then
        echo "$FILEDELETEFAILED"

    else
        echo "$FILEDELETESUCCESS"
        echo "$FILECREATESTART"
        cat ${target} | awk -f ./lib/convert.awk >./assets/outdata.txt
    fi
    if [ -e ./assets/outdata.txt ]; then
        echo "$FILECREATESUCCESS"
    else
        echo "$FILECREATEFAILED"
    fi
}
autoreconfig() {
    rm -r ./assets/outdata.txt
    sleep 1
    echo "$FAILEDELETENOW"
    echo "ファイルが削除できているか確認しています..."
    if [ -e $outputdata ]; then
        echo "$FILEDELETEFAILED"
        cat ${target} | awk -f ./lib/convert.awk >./assets/outdata.txt
    else
        cat ${target} | awk -f ./lib/convert.awk >./assets/outdata.txt
        echo "$FILEDELETESUCCESS"
        echo "$FILECREATESTART"
    fi
    if [ -e ./assets/outdata.txt ]; then
        echo "$FILECREATESUCCESS"
    else
        echo "$FILECREATEFAILED"
        read -p "再試行しますか? (y/n)" RETRY
        case "$RETRY" in
        [yY])
            cat ${target} | awk -f ./lib/convert.awk >./assets/outdata.txt
            if [ -e ./assets/outdata.txt ]; then
                echo "$FILECREATESUCCESS"
            else
                echo "$FILEDELETESUCCESS。"
                echo "ファイルの生成に合計2回失敗したため、サービスを終了します"
                echo "再度実行し、ファイルの生成に失敗する場合は製作者に報告を宜しくおねがいします"
            fi
            ;;
        [nN])
            echo "$ENDSERVICE"
            ;;
        esac
    fi
}
vcheck() {
    #新バージョンアップ
    curl -sl https://akari.fiid.net/app/amb/newversion.txt >newversion.txt
    if [ $version = $newversion ]; then
        echo -e '現在のambは\e[1;37;32m最新バージョン\e[0mで実行中です '
    else
        read -p "$最新のデータをダウンロードしますか?(y/n)" Newversiondata
        case "$Newversiondata" in
        [yY])
            #本番用
            echo "$FILEDOWNLOADSTART"
            wget https://github.com/yupix/amb/releases/download/$newversion/amb$newversion-linux.zip
            unzip -o amb$newversion-linux.zip
            cp -r ./amb/* ./
            rm -rf ./amb
            ;;
        [tT])
            #動作テスト用
            curl -OL https://akari.fiid.net/app/releases/download/$newversion/amb$newversion-Linux.zip
            unzip -o amb$newversion-linux.zip
            cp -r ./amb/* ./
            rm -r ./amb
            ;;
        [nN])
            echo "アップデートをキャンセルしました"
            echo "システムを終了します..."
            ;;
        esac
    fi
}

versioncheck() {
    #新しいバージョン
    rm -r ./newversion.txt
    curl -sl https://akari.fiid.net/app/amb/newversion.txt >newversion.txt
    if [ $version = $newversion ]; then
        echo -e '現在のambは\e[1;37;32m最新バージョン\e[0mで実行中です '
    else
        echo "最新のデータをダウンロードしますか?"
        echo "使用可能 (Y)es / (N)o"
        read Newversiondata
        case "$Newversiondata" in
        [yY])
            #本番用
            wget https:/akari.fiid.net/releases/download/$newversion/amb$newversion-Linux.zip
            mv ./amb$newversion-Linux.zip ../amb$newversion-Linux.zip
            cd ../
            rm -r ./amb
            unzip ./amb$newversion-Linux.zip
            rm -r ./amb$newversion-Linux.zip
            mv ./amb$newversion-Linux ./amb
            ;;
        [tT])
            #動作テスト用
            curl -OL https://akari.fiid.net/app/releases/download/$newversion/amb$newversion-Linux.zip
            mv ./amb$newversion-Linux.zip ../amb$newversion-Linux.zip
            cd ../
            rm -r ./amb
            unzip ./amb$newversion-Linux.zip
            rm -r ./amb$newversion-Linux.zip
            mv ./amb$newversion-Linux ./amb
            ;;
        [nN])
            echo "アップデートをキャンセルしました"
            echo "MusicBotを起動します..."
            botstart
            ;;
        esac
    fi
}

#新型
botstart() {
    while :; do
        #discordファイルが存在するかチェック
        for ((i = 0; i < ${#chars}; i++)); do
            sleep 0.2
            echo -en "${chars:$i:1} SYSTEMファイルの確認 1/3" "\r"
        done
        if [ -e $SYSTEMFILE ]; then
            echo "SYSTEMファイルの確認に成功! 1/3"
            #musicファイルが存在するかチェック
            for ((i = 0; i < ${#chars}; i++)); do
                sleep 0.2
                echo -en "${chars:$i:1} SYSTEMファイルの確認 2/3" "\r"
            done
            if [ -e $SYSTEMFILEMUSIC ]; then
                echo "SYSTEMファイルの確認に成功! 2/3"
                #jarファイルがあるかチェック
                for ((i = 0; i < ${#chars}; i++)); do
                    sleep 0.2
                    echo -en "${chars:$i:1} SYSTEMファイルの確認 3/3" "\r"
                done
                if [ -e $JAR ]; then
                    echo "SYSTEMファイルの確認に成功! 3/3"
                    cd $FILE
                    java -jar JMusicBot-$VERSION-$EDITION.jar &
                    echo -e 'BOTSTATUS: \e[1;37;32mONLINE\e[0m'
                    read -p "e でSystemを終了します" SERVICEEXIT
                    sleep 1
                    case "$SERVICEEXIT" in
                    [e])
                        pid=$!
                        kill $pid
                        echo "$SERVICECHECK"
                        sleep 2
                        count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
                        if [ $count = 0 ]; then
                            echo "$SERVICEDEAD"
                        else
                            echo "$SERVICEALIVE"
                        fi
                        echo "$ENDSERVICE"
                        exit
                        ;;
                    esac
                else
                    echo "ERROR SYSTEMファイルの確認に失敗 3/3"
                    echo "JARファイルが存在しません"
                    echo "JARファイルをダウンロードしますか?"
                    echo "使用可能 (y)es (n)o"
                    while :; do
                        read INPUT_DATA
                        if [ $INPUT_DATA = y ]; then
                            echo "$FILEDONWLOADSTART"
                            wget -q https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-$EDITION.jar
                        elif [ $INPUT_DATA = n ]; then
                            echo "JARファイルのダウンロードをキャンセルしました。"
                            echo "サービスを終了します"
                            exit 0
                        else
                            echo "(y)es又は(n)oを入力してください"
                        fi
                    done
                fi
            else
                echo "SYSTEMファイルの確認に成功! 2/3"
                echo "musicファイルが不足しています。"
                echo "$FILECREATESTART"
                mkdir "discord/music/"
                if [ -e discord/music/ ]; then
                    echo "$FILECREATESUCCESS"
                else
                    echo "$FILECREATEFAILED"
                fi
            fi
        #discordファイルが無かった場合
        else
            echo "SYSTEMファイルの確認に成功! 1/3"
            echo "discordファイルが不足しています。"
            echo "$FILECREATESTART"
            mkdir "discord"
            if [ -e discord ]; then
                echo "$FILECREATESUCCESS"
            else
                echo "$FILECREATEFAILED"
            fi
        fi
    done
}

#旧型
oldbotstart() {
    echo "SYSTEMFILEが存在するか確認しています..."
    echo "ファイルを確認中 1/2"
    if [ -e $SYSTEMFILE ]; then
        echo "$FILECHECKSUCCSESS"
        echo "ファイルを確認中 2/2"
        if [ -e $SYSTEMFILEMUSIC ]; then
            echo "$FILECHECKSUCCSESS"
            echo "$SYSTEMSTART"
            systemstart
        else
            echo "$FILECHECKFAILED"
            echo "$FAILECREATE"
            mkdir "discord/music/"
            echo "$SYSTEMSTART"
            systemstart
        fi
    else
        echo "SYSTEMFILEが欠落しています"
        mkdir "discord"
        echo "$FILECREATESUCCESS"
        echo "ファイルを確認中 2/2"
        if [ -e $SYSTEMFILEMUSIC ]; then
            echo "$FILECHECKSUCCSESS"
            echo "$SYSTEMSTART"
            systemstart
        else
            echo "$FILECHECKFAILED"
            echo "$FAILECREATE"
            mkdir "discord/music/"
            echo "$SYSTEMSTART"
            systemstart
        fi
        if [ -e $SYSTEMFILE ]; then
            echo "$FILECHECKSUCCSESS"
            echo "$SYSTEMSTART"
            systemstart
            echo "ファイルを確認中 2/2"
            if [ -e $SYSTEMFILEMUSIC ]; then
                echo "ファイル"
            else
                echo "test"
            fi
        fi
    fi
}
systemstart() {
    if [ -e $JAR ]; then
        echo "jarファイルにchmodで権限を付与します"
        #sudo chmod u+x $JAR
        chmod u+x $JAR
        echo "$FILETRUE"
        echo "$BOTSTART"
        cd $FILE
        java -jar JMusicBot-$VERSION-$EDITION.jar &
        echo -e 'BOTSTATUS: \e[1;37;32mONLINE\e[0m'
        read -p "e でSystemを終了します" SERVICEEXIT
        sleep 1
        case "$SERVICEEXIT" in
        [e])
            pid=$!
            kill $pid
            echo "$SERVICECHECK"
            sleep 2
            count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
            if [ $count = 0 ]; then
                echo "$SERVICEDEAD"
            else
                echo "$SERVICEALIVE"
            fi
            echo "$ENDSERVICE"
            exit
            ;;
        esac
    else
        echo "$JARFALSE"
        read -p "$FILEDOWNLOAD " DATA
        case "$DATA" in
        [yY])
            echo "$FILEDOWNLOADSTART"
            wget -q https://github.com/jagrosh/MusicBot/releases/download/$VERSION/JMusicBot-$VERSION-$EDITION.jar
            if [ -e $JAR ]; then
                echo "$FILEDOWNLOADFAILED"
                exit
            else
                echo "$FILEDOWNLOADUCCESS"
            fi
            mv ./JMusicBot-$VERSION-$EDITION.jar $SELF_DIR_PATH/discord/music/
            cd $FILE
            java -jar JMusicBot-$VERSION-$EDITION.jar &
            echo -e 'BOTSTATUS: \e[1;37;32mONLINE\e[0m'
            read -p "e でSystemを終了します" SERVICEEXIT
            sleep 1
            case "$SERVICEEXIT" in
            [e])
                pid=$!
                kill $pid
                echo "$SERVICECHECK"
                sleep 2
                count=$(ps x -ef | grep $ProcessName | grep -v grep | wc -l)
                if [ $count = 0 ]; then
                    echo "$SERVICEDEAD"
                else
                    echo "$SERVICEALIVE(未実装です)"
                fi
                echo "$ENDSERVICE"
                exit
                ;;
            esac
            ;;
        esac
    fi
}
SPINNER() {
    for ((i = 0; i < ${#chars}; i++)); do
        sleep 0.05
        echo -en "${chars:$i:1} $PROGRESS_STATUS " "\r"
    done
}
SPINNER_FILEMAKING() {
    for ((i = 0; i < ${#chars}; i++)); do
        sleep 0.2
        echo -en "${chars:$i:1} ファイルの作成中 " "\r"
    done
}
SPINNER_FILEDOWNLOAD() {
    for ((i = 0; i < ${#chars}; i++)); do
        sleep 0.2
        echo -en "${chars:$i:1} ダウンロード中 " "\r"
    done
}
SPINNER_FILECHECK() {
    for ((i = 0; i < ${#chars}; i++)); do
        sleep 0.1
        echo -en "${chars:$i:1} ファイルの確認中 " "\r"
    done
}

FILEDOWNLOADFAILEDMESSEAGE() {
    echo "エラーコード: Ais1yoocu"
    echo "jarファイルのダウンロードに失敗しました。"
    echo "ネットワークに接続されているか等を確認してから再度実行してみてください。"
    echo "一向に動作が改善されない場合は開発者に連絡をお願い致します。"
    break
    exit 1
}
JARDOWNLOADSUCCESS() {
    echo "jarファイルのダウンロードに成功しました"
}

DONWLOAD_CANCELLATION() {
    echo "ダウンロードをキャンセルしたため、サービスを終了します"
    break
    exit 0
}

CHANGE_SERVER_PROCESS_NAME() {
    echo "サーバーのプロセス名を変更します。"
    while :; do
        read input_serverprocess_name
        if [ -n $input_serverprocess_name ]; then
            echo "サーバーのプロセス名 $input_serverprocess_name に変更します。よろしいですか? (Y)es / (N)o "
            read input_confirm
            case $input_confirm in
            [yY])
                sed -i -e 's/SCREEN_NAME='$SCREEN_NAME'/SCREEN_NAME='$input_serverprocess_name'/' ./setting.txt
                echo "プロセス名を $input_serverprocess_name に変更しました"
                break
                ;;
            [nN])
                echo "変更をキャンセルしました。"
                echo "サービスを終了します。"
                exit 0
                ;;
            *)
                echo "(Y)es または (N)o を入力してください"
                ;;
            esac
        fi
    done
}
CHANGE_SERVER_JAR_NAME() {
    echo "サーバーのJAR名を変更します。"
    while :; do
        read input_serverjar_name
        if [ -n $input_serverjar_name ]; then
            echo "サーバーJAR名を $input_serverjar_name に変更します。よろしいですか? (Y)es / (N)o "
            read input_confirm
            case $input_confirm in
            [yY])
                sed -i -e 's/SERVER_FILE='$SERVER_FILE'/SERVER_FILE='$input_serverjar_name'/' ./setting.txt
                echo "サーバーJAR名を $input_serverjar_name に変更しました"
                break
                ;;
            [nN])
                echo "変更をキャンセルしました。"
                echo "サービスを終了します。"
                exit 0
                ;;
            *)
                echo "(Y)es または (N)o を入力してください"
                ;;
            esac
        fi
    done
}

CHANGE_SERVER_MIN_MEMORY() {
    echo "サーバーの最小メモリを変更します。"
    while :; do
        read input_mem_min
        if [ -n $input_mem_min ]; then
            if expr "$input_mem_min" : '[0-9]*'; then
                if [[ $input_mem_min -le $SMEM_MAX ]]; then
                    echo "サーバーの最小メモリを $input_mem_min$MEM_UNIT に変更します。よろしいですか? (Y)es / (N)o "
                    read input_confirm
                    case $input_confirm in
                    [yY])
                        sed -i -e 's/SMEM_MIN='$SMEM_MIN'/SMEM_MIN='$input_mem_min'/' ./setting.txt
                        sed -i -e 's/MEM_MIN='$MEM_MIN'/MEM_MIN='$input_mem_min$MEM_UNIT'/' ./setting.txt
                        echo "サーバーの最小メモリを $input_mem_min に変更しました"
                        break
                        ;;
                    [nN])
                        echo "変更をキャンセルしました。"
                        echo "サービスを終了します。"
                        exit 0
                        ;;
                    *)
                        echo "(Y)es または (N)o を入力してください"
                        ;;
                    esac
                else
                    echo "最小メモリの値が最大メモリを上回る為、再入力をお願いします。"
                    exit 0
                fi
            else
                echo "数字を入力してください。"
                echo "単位を変更するにはsettingsの6番目を選択してください"
            fi
        fi
    done
}
CHANGE_SERVER_MAX_MEMORY() {
    echo "サーバーの最大メモリを変更します。"
    while :; do
        read input_mem_max
        if [ -n $input_mem_max ]; then
            if expr "$input_mem_max" : '[0-9]*'; then
                if [[ $input_mem_max -gt $SMEM_MAX ]]; then
                    echo "サーバーの最大メモリを $input_mem_max$MEM_UNIT に変更します。よろしいですか? (Y)es / (N)o "
                    read input_confirm
                    case $input_confirm in
                    [yY])
                        sed -i -e 's/SMEM_MAX='$SMEM_MAX'/SMEM_MAX='$input_mem_max'/' ./setting.txt
                        sed -i -e 's/MEM_MAX='$MEM_MAX'/MEM_MAX='$input_mem_max$MEM_UNIT'/' ./setting.txt
                        echo "サーバーの最大メモリを $input_mem_max に変更しました"
                        break
                        ;;
                    [nN])
                        echo "変更をキャンセルしました。"
                        echo "サービスを終了します。"
                        exit 0
                        ;;
                    *)
                        echo "(Y)es または (N)o を入力してください"
                        ;;
                    esac
                else
                    echo "最大メモリの値が最小メモリを下回る為、再入力をお願いします。"
                    exit 0
                fi
            else
                echo "数字を入力してください。"
                echo "単位を変更するにはsettingsの6番目を選択してください"
            fi
        fi
    done
}
SERVER_CREATE() {
    . ./lib/minecraft/prsr_ce.sh
}
#------------------------------------------------------------------------------#
case $1 in
#Minecraft系
mc)
    firststart
    while :; do
        echo "Minecraft"
        echo "srce | サーバーを作成します。"
        echo "srmt ■ | サーバーを起動します。"
        read -p ">" INPUT_DATA
        case "$INPUT_DATA" in
        srce)
            echo "1. OfficialServer 2. PaperServer"
            echo "3. SpigotServer   4. ForgeServer"
            echo "5. SpongeServer   6. BungeeCord"
            echo "7. WaterFall      8. Travertine"
            read INPUT_SERVER_TYPE
            case $INPUT_SERVER_TYPE in
            [1])
                SERVER_EDITION="official"
                echo "OfficialServer"
                echo -e "VersionList: | \033[1;37m1.2.5\033[0;39m | \033[1;37m1.3.1\033[0;39m | \033[1;37m1.3.2\033[0;39m | \033[1;37m1.4.2\033[0;39m | \033[1;37m1.4.4\033[0;39m | \033[1;37m1.4.5\033[0;39m | \033[1;37m1.4.6\033[0;39m | \033[1;37m1.4.7\033[0;39m | \033[1;37m1.5.2\033[0;39m | \033[1;37m1.5.2\033[0;39m | \033[1;37m1.6.1\033[0;39m | \033[1;37m1.6.2\033[0;39m | \033[1;37m1.6.4\033[0;39m |"
                echo -e "| \033[1;37m1.7.2\033[0;39m | \033[1;37m1.7.5\033[0;39m | \033[1;37m1.7.6\033[0;39m | \033[1;37m1.7.7\033[0;39m | \033[1;37m1.7.8\033[0;39m | \033[1;37m1.7.9\033[0;39m | \033[1;37m1.7.10\033[0;39m | \033[1;37m1.8\033[0;39m | \033[1;37m1.8.1\033[0;39m | \033[1;37m1.8.2\033[0;39m | \033[1;37m1.8.3\033[0;39m | \033[1;37m1.8.4\033[0;39m | \033[1;37m1.8.5\033[0;39m | \033[1;37m1.8.6\033[0;39m | \033[1;37m1.8.7\033[0;39m | \033[1;37m1.8.8\033[0;39m | \033[1;37m1.8.9\033[0;39m |"
                echo -e "| \033[1;37m1.9\033[0;39m | \033[1;37m1.9.1\033[0;39m | \033[1;37m1.9.2\033[0;39m | \033[1;37m1.9.3\033[0;39m | \033[1;37m1.9.4\033[0;39m | \033[1;37m1.10\033[0;39m | \033[1;37m1.10.1\033[0;39m | \033[1;37m1.10.2\033[0;39m | \033[1;37m1.11\033[0;39m | \033[1;37m1.11.1\033[0;39m | \033[1;37m1.11.2\033[0;39m | \033[1;37m1.12\033[0;39m | \033[1;37m1.12.1\033[0;39m | \033[1;37m1.12.2\033[0;39m | \033[1;37m1.13\033[0;39m | \033[1;37m1.13.1\033[0;39m | \033[1;37m1.13.2\033[0;39m |"
                echo -e "| \033[1;37m1.14\033[0;39m | \033[1;37m1.14.1\033[0;39m | \033[1;37m1.14.2\033[0;39m | \033[1;37m1.14.3\033[0;39m | \033[1;37m1.14.4\033[0;39m | \033[1;37m1.15\033[0;39m | \033[1;37m1.15.1\033[0;39m | \033[1;37m1.15.2\033[0;39m |"
                . ./lib/minecraft/officialserver.sh
                . ./lib/minecraft/olsr_dr.sh
                exit 0
                ;;
            [2])
                SERVER_EDITION="paper"
                echo "PaperServer"
                echo -e "VersionList: | \033[1;37m1.8.8\033[0;39m | \033[1;37m1.9.4\033[0;39m | \033[1;37m1.10.2\033[0;39m | \033[1;37m1.11.2\033[0;39m | \033[1;37m1.12.2\033[0;39m | \033[1;37m1.13.2\033[0;39m | \033[1;37m1.14.4\033[0;39m | \033[1;37m1.15.2\033[0;39m |"
                . ./lib/minecraft/paperserver.sh
                . ./lib/minecraft/prsr_dr.sh
                ;;
            [3]) ;;

            [4]) ;;

            *)
                echo "数字を入力してください。"
                ;;
            esac
            ;;
        srmt)
            echo "管理するサーバーのコマンドを入力してください"
            read -p ">" serverstartlist
            case $serverstartlist in



;;
                *)
                #不正なキー入力
                echo "上記に出ているコマンドを入力してください。"
                ;;
            esac
            ;;
        esac
    done
    ;;

#DiscordBot系
discord)
    echo "w"
    ;;
*)

    echo -e "\033[1;37m##========================================##\033[0;39m"
    echo "##██╗███╗   ██╗████████╗███████╗██╗      ##"
    echo "##██║████╗  ██║╚══██╔══╝██╔════╝██║      ##"
    echo "##██║██╔██╗ ██║   ██║   ███████╗██║      ##"
    echo "##██║██║╚██╗██║   ██║   ╚════██║██║      ##"
    echo "##██║██║ ╚████║   ██║   ███████║███████╗ ##"
    echo "##╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚══════╝ ##"
    echo -e "\033[1;37m##========================================##\033[0;39m"
    echo -e "\033[0;31mstart\033[1;39m: BOTを起動します"
    echo -e "\033[0;31mremove\033[1;39m: jarファイルを削除します"
    echo -e "\033[0;31mRECONFIG\033[1;39m: 出力ファイルを再生成します"
    ;;
esac
exit 0
