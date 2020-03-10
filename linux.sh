#!/usr/bin/env bash
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
#Official
SERVER_JARLIST_PATH="./minecraft/versionlist/official/"
#Paper
SERVER_PAPERLIST_PATH="./minecraft/versionlist/paper/"
#Spigot
SERVER_SPIGOTLIST_PATH="./minecraft/versionlist/spigot/"
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
# https://akarinext.org/wordpress/
#------------------------------------------------------------------------------#

#コマンド
#設定の数
SETTING_MAX="5"
firststart() {
    if [ $firststart = 0 ]; then
        sed -i -e 's/firststart="'$firststart'"/firststart="'1'"/' ./assets/settings.txt
        echo "INTSLをインストールしていただきありがとうございます。"
        echo "本Projectを自分好みに動かすために初期設定を行うことを推奨します"
        echo "使用可能 (y)es (n)o"
        while :; do
            read INPUT_DATA
            if [ $INPUT_DATA = yes ]; then
                while :; do
                    read -p ">" SETTING_INPUT
                    if [[ $SETTING_NUMBER != $SETTING_MAX ]]; then
                        #wget -q number${MODNUMBER} -O $MODNUMBER
                        SETTING_NUMBER=$((SETTING_NUMBER + 1))
                        echo "$SETTING_NUMBER"
                        SETTING_SED="\$ft_sg_sed${SETTING_NUMBER}"
                    fi

                    if [[ $SETTING_NUMBER = $SETTING_MAX ]]; then
                        echo "これで初期設定は終わりです、お疲れ様でした。"
                        echo "この他にもExtension等様々な物の有効化方法が有りますが、詳しくは https://akari.fiid.net/dev/amb/top をご覧ください!"
                        echo "それでは良いDiscordBotライフを!"
                        sleep 3
                        break
                    fi

                    #設定sed用
                    ft_sg_sed1=$(sed -i -e 's/setting_VersionCheck="'$setting_VersionCheck'"/setting_VersionCheck="'$SETTING_INPUT'"/' ./assets/settings.txt)
                    ft_sg_sed2=$(sed -i -e 's/setting_botinvite="'$setting_botinvite'"/setting_botinvite="'$SETTING_INPU'"/' ./assets/settings.txt)
                    ft_sg_sed3=$(sed -i -e 's/setting_outputdata="'$setting_outputdata'"/setting_outputdata="'$SETTING_INPU'"/' ./assets/settings.txt)
                    ft_sg_sed4=$(sed -i -e 's/setting_backuptime="'$setting_backuptime'"/setting_backuptime="'$SETTING_INPU'"/' ./assets/settings.txt)
                    ft_sg_sed5=$(sed -i -e 's/setting_resetspigot="'$setting_resetspigot'"/setting_resetspigot="'$SETTING_INPU'"/' ./assets/settings.txt)

                    if [[ $SETTING_NUMBER = 1 ]]; then
                        echo "#BOTを起動した際にVercheckを走らせるかどうか (default = yes)"
                    elif [[ $SETTING_NUMBER = 2 ]]; then
                        echo "BOTを起動した際に招待リンクを表示するかどうか (default = yes)"
                    fi
                    if [[ $SETTING_NUMBER = 3 ]]; then
                        echo "BOTを起動した際にTOKEN等の情報を更新するかどうか (default = yes)"
                    elif [[ $SETTING_NUMBER = 4 ]]; then
                        echo "バックアップを行うか否か (default = yes)"
                    fi
                    case $SETTING_INPUT in
                    [y])

                        echo "$SETTING_SED"
                        eval $SETTING_SED
                        echo "設定を変更しました。"
                        ;;
                    [n])
                        echo "設定を変更しました。"
                        ;;
                    *)
                        echo "(y)es or (n)o を入力してください。"
                        ;;
                    esac
                done
                break
            elif [ $INPUT_DATA = n ]; then
                echo "キャンセルしました!"
                echo "自動的に元の動作を行います。"
                break
            else
                echo "(y)es or (n)o を入力してください"
            fi
        done

    fi
}

SPINNER() {
    for ((i = 0; i < ${#chars}; i++)); do
        sleep 0.05
        echo -en "${chars:$i:1} $PROGRESS_STATUS " "\r"
    done
}

serverlistoutput() {
    echo "サーバーリストをアウトプットします。"
    while :; do
        if [[ -e OUTPUTSERVERLIST.txt ]]; then
            rm -r OUTPUTSERVERLIST.txt
        else
            while [[ ! -e OUTPUTSERVERLIST.txt ]]; do
                PROGRESS_STATUS="アウトプット中..."
                cat linux.sh | awk '/STARTSERVERLIST/,/ENDSERVERLIST/' >OUTPUTSERVERLIST.txt
                sed -i -e '1,1d' OUTPUTSERVERLIST.txt
                #先頭削除
                sed -i -e '$d' OUTPUTSERVERLIST.txt
                #最終行削除
                sed -i -e '1d' OUTPUTSERVERLIST.txt
                #空白削除
                sed -i '/^$/d' OUTPUTSERVERLIST.txt
            done
            break
        fi
    done
    echo "アウトプットに成功しました。"
}

#INTSLGETV() {
#    VERSIONGET=$(echo "$INTVERSIONBODY" | sed -e 's/\(.\{1\}\)/.\1/g')
#}

vcheck() {
    while :; do
        if [[ -e ./assets/new-version.txt ]]; then
            PROGRESS_STATUS="既存のファイルを削除しています。"
            SPINNER
            rm -r ./assets/new-version.txt
        else
            PROGRESS_STATUS="新しいバージョンが無いかサーバーに問い合わせています。"
            wget -q ${INTREPOURL}pub/intsl/new-version.txt -P ./assets/
            if [[ -e ./assets/new-version.txt ]]; then
                #                INTSLGETV
                #                NEWINTSLGETV
                #${INTVERSIONHEAD}$VERSIONGET
                . ./assets/new-version.txt
                NEWINTSLGETV=$(echo "$INTNEWVERSIONBODY" | sed -e 's/\(.\{1\}\)/.\1/g')
                if [[ ${INTNEWVERSIONHEAD}${INTNEWVERSIONBODY} -gt ${INTVERSIONHEAD}${INTVERSIONBODY} ]]; then
                    echo "新しいバージョンが存在します            "
                    echo -e "\e[31mCurrent: INTSL-${INTVERSIONHEAD}${INTVERSIONBODY}\e[m ⇛  \e[32mNew: INTSL-${INTNEWVERSIONHEAD}${INTNEWVERSIONBODY}\e[m"
                    echo "ファイルをダウンロードしますか?"
                    echo "使用可能 (Y)es (N)o default(Y)es"
                    read -p ">" INPUT_DATA
                    INPUT_DATA=${INPUT_DATA:y}
                    case $INPUT_DATA in
                    [yY])
                        echo "アップデートを開始します。"
                        while [[ ! -e ./INTSL-${INTNEWVERSIONHEAD}${NEWINTSLGETV}-${INTEDITION}.zip ]]; do
                            PROGRESS_STATUS="データのダウンロード中"
                            SPINNER
                            wget -q https://repo.akarinext.org/pub/intsl/${INTNEWVERSIONHEAD}${NEWINTSLGETV}/INTSL-${INTNEWVERSIONHEAD}${NEWINTSLGETV}-${INTEDITION}.zip
                        done
                        echo "ダウンロードに成功"
                        serverlistoutput
                        unzip -qonu ./INTSL-${INTNEWVERSIONHEAD}${NEWINTSLGETV}-${INTEDITION}.zip
                        if [[ -e INTSL-${INTNEWVERSIONHEAD}${NEWINTSLGETV}-${INTEDITION} ]]; then
                            cd ./INTSL-${INTNEWVERSIONHEAD}${NEWINTSLGETV}-${INTEDITION}
                            sudo cp -r . ../
                            cd -
                        else
                            echo "何か問題が発生したようです。"
                            echo "Systemを保護するためにサービスを終了します。"
                            break
                        fi
                        . ./assets/variable.txt
                        if [[ ${INTNEWVERSIONHEAD}${INTNEWVERSIONBODY} -gt ${INTVERSIONHEAD}${INTVERSIONBODY} ]]; then
                            echo "バージョンアップに失敗"
                        else
                            echo "バージョンアップに成功"

                        fi
                        ;;
                    [nN])
                        echo "キャンセルしました。"
                        echo ""
                        ;;
                    esac
                    echo $name
                    break
                else
                    echo -e '現在のINTSLは\e[1;37;32m最新バージョン\e[0mで実行中です '
                    break
                fi
            else
                echo "ファイルのダウンロードに失敗しました。"
                echo "考えられる理由として、RepositoryServerがDownしている、又は"
                echo "ネットの接続が不安定な可能性が有ります。"
                break
            fi
        fi
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
#INTSL本体
main)
    echo "MAIN SYSTEM"
    echo "■ extension | 拡張機能を管理できます"
    read -p ">" INPUT_DATA
    case $INPUT_DATA in
    extension)
        echo "■ use | 拡張機能を使用します。"
        echo "■ import | 拡張機能をインポートします。"
        echo "■ list | 拡張機能の一覧を表示します。"
        read -p ">" INPUT_EXTENSION_DATA
        case $INPUT_EXTENSION_DATA in
        use)
            . ./lib/main/extension_manager.sh
            ;;
        import)
            echo "インポートするshの名前を入力してください。"
            read -p ">" INPUT_EXTENSION_NAME
            if [[ -e ${INPUT_EXTENSION_NAME}.sh ]]; then
                #拡張機能系だけを保存するよう
                GETIEXT=$(cat ./${INPUT_EXTENSION_NAME}.sh | grep -e IEXT -e INT -e HEAD -e BODY -e VURL >>./${INPUT_EXTENSION_NAME}.txt)
                MAXLINE=$(cat ${INPUT_EXTENSION_NAME}.txt | wc -l)
                echo "$MAXLINE"
                while [[ $COUNT != $MAXLINE ]]; do
                    . ./assets/settings.txt
                    PROGRESS_STATUS="進捗 $COUNT / $MAXLINE"
                    SPINNER
                    COUNT=$(($COUNT + 1))
                    GETLINE=$(sed -n ${COUNT}P ${INPUT_EXTENSION_NAME}.txt)
                    sed -i ''$EXSTENSIONLANE'i '"$GETLINE"'' ./assets/extension.txt
                    #新しいラインの数値作成
                    NEWSERVERLANE=$((EXSTENSIONLANE + 1))
                    #拡張機能の追加ライン
                    sed -i -e 's/EXSTENSIONLANE="'$EXSTENSIONLANE'"/EXSTENSIONLANE="'$NEWSERVERLANE'"/' ./assets/settings.txt
                done
                if [[ ! -e ./lib/extensions ]]; then
                    mkdir ./lib/extensions
                fi
                mv ./${INPUT_EXTENSION_NAME}.sh ./lib/extensions/
                MAXLINE=$(cat ${INPUT_EXTENSION_NAME}.sh | wc -l)
                sed -i ''$EXTADDLINE'i'${INPUT_EXTENSION_NAME}\)'' ./lib/main/extension_manager.sh
                sed -i ''$EXTADDLINE'a ;;' ./lib/main/extension_manager.sh
                sed -i ''$EXTADDLINE'a . ./lib/extensions/'${INPUT_EXTENSION_NAME}.sh'' ./lib/main/extension_manager.sh
                #ライン追加のライン数を変更
                COUNTADD=$((EXTADDLINE + 3))
                sed -i -e 's/EXTADDLINE="'$EXTADDLINE'"/EXTADDLINE="'$COUNTADD'"/' ./assets/settings.txt
                . ./assets/extension.txt
                NEWEXTENSIONS=$((EXTENSIONS + 1))
                #エクステンションの数追加
                sed -i -e 's/EXTENSIONS="'$EXTENSIONS'"/EXTENSIONS="'$NEWEXTENSIONS'"/' ./assets/extension.txt
                . ./assets/extension.txt
                sed -i -e "s/IEXT/IE_XT$EXTENSIONS/g" ./assets/extension.txt
                sed -i -e "s/INTEXT/INT_EXT$EXTENSIONS/g" ./assets/extension.txt
                sed -i -e "s/HEAD/IEHE_AD$EXTENSIONS/g" ./assets/extension.txt
                sed -i -e "s/BODY/BO_DY$EXTENSIONS/g" ./assets/extension.txt
                sed -i -e "s/VURL/V_URL$EXTENSIONS/g" ./assets/extension.txt
                sed -i -e "s/EXDOWNLOAD/EX_DOWNLOAD$EXTENSIONS/g" ./assets/extension.txt
                rm -r ${INPUT_EXTENSION_NAME}.txt
                echo "shが存在します。"
            else
                echo "shが存在しません"
            fi
            ;;
        list)
            . ./assets/extension.txt
            echo "拡張機能の数: ${EXTENSIONS}個"
            echo "========================================"
            while [[ $COUNT != $EXTENSIONS ]]; do
                COUNT=$(($COUNT + 1))
                EXT_NAME="IE_XT"
                eval $EXT_NAME="\$IE_XT$COUNT"
                EXT_VERSION="INT_EXT"
                eval $EXT_VERSION="\$INT_EXT$COUNT"
                echo "拡張機能名: $IE_XT"
                echo "バージョン: $INT_EXT"
                echo "========================================"
            done
            ;;
        vcheck)
            . ./assets/extension.txt
            #for ((i = 1; i <= $EXTENSIONS; i++)); do
            while [[ $PLAYCOUNT != $EXTENSIONS ]]; do
                PROGRESS_STATUS="アップデートの確認中 $3 / $EXTENSIONS"
                SPINNER
                COUNT=$(($COUNT + 1))
                PLAYCOUNT=$(($PLAYCOUNT + 1))
                EXT_NAME="V_URL"
                eval $EXT_NAME="\$V_URL$COUNT"
                wget -q $V_URL
                . ./newversion.txt
                NEWINTSLGETV=$(echo "$BO_DY" | sed -e 's/\(.\{1\}\)/.\1/g')
                EXT_NAME="IE_XT"
                eval $EXT_NAME="\$IE_XT$COUNT"
                EXT_VERSION="INT_EXT"
                eval $EXT_VERSION="\$INT_EXT$COUNT"
                EXT_HEAD="IEHE_AD"
                eval $EXT_HEAD="\$IEHE_AD$COUNT"
                EXT_BODY="BO_DY"
                eval $EXT_BODY="\$BO_DY$COUNT"
                if [[ ${NEWEXTHEAD}${NEWEXTBODY} -gt ${IEHE_AD}${BO_DY} ]]; then
                    #NEWVER=$(echo "$INTNEWVERSIONBODY" | sed -e 's/\(.\{1\}\)/.\1/g')
                    echo "$IE_XT に更新があります"
                    echo -e '\e[1;37mExtension     Current     Latest\e[m'
                    echo "================================="
                    echo -e "$IE_XT     $INT_EXT\e[32m         $NEWVERSION\e[m"
                    echo "更新を行いますか?"
                    echo "(Y)es / (N)o"
                    read -p ">" INPUT_DATA
                    case $INPUT_DATA in
                    [yY])
                        echo "ダウンロードを開始します。"
                        echo "DOWNLOADURL: $EXDOWNLOAD"
                        wget -q $EXDOWNLOAD
                        #if [[ -e ${IE_XT}.sh ]]; then
                        #    echo "a"
                        #fi
                        #バージョン情報を更新
                        sed -i -e 's/INT_EXT'$COUNT'="'$INT_EXT'"/INT_EXT'$COUNT'="'$NEWVERSION'"/' ./assets/extension.txt
                        #HEAD情報を更新する
                        sed -i -e 's/IEHE_AD'$COUNT'="'$IEHE_AD'"/IEHE_AD'$COUNT'="'$NEWEXTHEAD'"/' ./assets/extension.txt
                        #BODY情報を更新する
                        sed -i -e 's/BO_DY'$COUNT'="'$BO_DY'"/BO_DY'$COUNT'="'$NEWEXTBODY'"/' ./assets/extension.txt
                        #ダウンロード処理
                        #バージョンのファイルを変更
                        ;;
                    [nN])
                        echo "キャンセルしました。"
                        ;;
                    esac
                fi
                #rm -r ./newversion.txt
            done
            ;;
        settings) ;;
        donwload) ;;
        esac
        ;;
    esac
    ;;

#Minecraft系
vcheck)
    vcheck
    ;;
mc)
    firststart
    while :; do
        echo "Minecraft"
        echo "■ srce | サーバーを作成します。"
        echo "■ srmt | サーバーを起動します。"
        echo "■ itst | 出力したデータをインポートします"
        echo "■ otst | サーバーリストを出力します"
        read -p ">" INPUT_DATA
        case "$INPUT_DATA" in
        srce)
            echo -e "   \033[1;37m_<----^¯¯¯¯<Server List>¯¯¯¯^---->_\033[0;39m"
            echo "❘   1. OfficialServer 2. PaperServer   ❘"
            echo "❘   3. SpigotServer   4. ForgeServer   ❘"
            echo "❘   5. SpongeServer   6. BungeeCord    ❘"
            echo "❘   7. WaterFall      8. Travertine    ❘"
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
            [3])
                SERVER_EDITION="spigot"
                echo "SpigotServer"
                . ./lib/minecraft/spigotserver.sh
                . ./lib/minecraft/stsr_dr.sh
                ;;
            [4])
                SERVER_EDITION="forge"
                echo "forgeserver"
                ;;
            *)
                echo "数字を入力してください。"
                ;;
            esac
            ;;
        gcst)
            read -p ">" INPUT_DATA
            case $INPUT_DATA in
            create)
                echo "登録するサーバー数を入力してください"
                read -p ">" SERVER_MAX
                while [[ $COUNT != $SERVER_MAX ]]; do
                    echo "サーバー名を入力してください。"
                    read -p ">" SERVER_NAME
                    PROGRESS_STATUS="実行ファイルの確認"
                    SPINNER
                    if [[ -e ./minecraft/serversh/${SERVER_NAME}.sh ]]; then
                        echo "実行ファイルが存在します。"
                        SERVER_CREATE_SERVER="${SERVER_NAME}.sh"
                        echo "インポートする名前$SERVER_CREATE_SERVER"
                        COUNT=$(($COUNT + 1))
                    else
                        echo "実行ファイルが存在しません。"
                    fi
                done
                ;;
            esac
            ;;
        import)
            if [[ -e OUTPUTSERVERLIST.txt ]]; then
                MAXLINE=$(cat OUTPUTSERVERLIST.txt | wc -l)
                while [[ $COUNT != $MAXLINE ]]; do
                    . ./assets/settings.txt
                    PROGRESS_STATUS="進捗 $COUNT / $MAXLINE"
                    SPINNER
                    COUNT=$(($COUNT + 1))
                    GETLINE=$(sed -n ${COUNT}P OUTPUTSERVERLIST.txt)
                    sed -i ''$SERVERLANE'i '"$GETLINE"'' ./linux.sh
                    #サーバーの追加する行変更
                    NEWSERVERLANE=$((SERVERLANE + 1))
                    sed -i -e 's/SERVERLANE="'$SERVERLANE'"/SERVERLANE="'$NEWSERVERLANE'"/' ./assets/settings.txt
                done
                echo -e "\e[1;37;32mIMPORT SUCCESS\e[0m"
            else
                echo "OUTPUTデータが存在しません。"
                echo "データをOUTPUTしてから再度実行してください。"
            fi
            ;;
        otst)
            serverlistoutput
            ;;
        srmt)
            echo "管理するサーバーのコマンドを入力してください"
            read -p ">" serverstartlist
            case $serverstartlist in
            #STARTSERVERLIST

            #ENDSERVERLIST
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
    echo "Discord"
    ;;
*)

    echo -e "\033[1;37m##========================================##\033[0;39m"
    echo "##██╗███╗   ██╗████████╗███████╗██╗       ##"
    echo "##██║████╗  ██║╚══██╔══╝██╔════╝██║       ##"
    echo "##██║██╔██╗ ██║   ██║   ███████╗██║       ##"
    echo "##██║██║╚██╗██║   ██║   ╚════██║██║       ##"
    echo "##██║██║ ╚████║   ██║   ███████║███████╗  ##"
    echo "##╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚══════╝  ##"
    echo -e "\033[1;37m##========================================##\033[0;39m"
    echo -e "\033[0;31mmain\033[1;39m: INTSLに関する事を設定できます"
    echo -e "   └   \033[0;31mextension\033[1;39m: 拡張機能を管理します"
    echo -e "       └   \033[0;31muse\033[1;39m: 拡張機能を使用します"
    echo -e "       └   \033[0;31mlist\033[1;39m: 拡張機能の一覧を表示します"
    echo -e "       └   \033[0;31mimport\033[1;39m: 拡張機能をインポートします"
    echo -e "\033[0;31mmc\033[1;39m: Minecraftに関する機能を開始します"
    echo -e "   └   \033[0;31msrce\033[1;39m: サーバーを作成します"
    echo -e "   └   \033[0;31msrmt\033[1;39m: サーバーを管理します"
    echo -e "   └   \033[0;31motst\033[1;39m: サーバーリストを出力します"
    echo -e "   └   \033[0;31mitst\033[1;39m: サーバーリストをインポートします"
    ;;
esac
case $2 in
tete)
    echo "今後用"
    ;;
esac
exit 0
