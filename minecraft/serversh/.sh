                #!/bin/bash
                cd 
                if [ ! -e eula.txt ]; then
                    echo "eulaファイルが存在しないため、再度実行し、ファイルを作成してください。"
                fi
                cp ./eula.txt ./eula-back.txt
                EULACONSENT=
                if [[ false = $EULACONSENT ]]; then
                    echo "EULA(MINECRAFT エンド ユーザー ライセンス条項)に同意していません。"
                    echo "こちらを読み、同意する場合は(Y)esキャンセルする場合は(N)oと入力してください"
                    echo "https://account.mojang.com/documents/minecraft_eula"
                    while :; do
                        read -p ">" INPUT_EULA_DATA
                        case $INPUT_EULA_DATA in
                        [yY])
                            echo "同意しました。"
                            sed -i -e 's/eula=false/eula=true/' ./eula.txt
                            break
                            ;;
                        [nN])
                            echo "キャンセルしました。"
                            break
                            ;;
                        *)
                            echo "(Y)esまたは(N)oを入力してください"
                            ;;
                        esac
                    done
                fi
                if [ \true = $SETTING_CONSOLE_LOG ]; then
                    java -jar ./server1.2.5.jar
                else
                    java -jar ./server1.2.5.jar &
                fi
