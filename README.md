![IntegrationShell](https://repo.akarinext.org/pub/intsl/intsl.gif "Image")
[![pipeline status](https://dev.akarinext.org/yupix/INTSL/badges/master/pipeline.svg)](https://dev.akarinext.org/yupix/INTSL/-/commits/master)

# INTSL
IntegrationShell(統合シェル)
このProjectは私が元々開発していた[amb](https://github.com/yupix.amb/)Projectを合わせ、
Minecraftのサーバー作成補助等様々な開発者やサーバー運営者にとって作業の効率化が行える様な物を
目指しています。
主な開発元は[ここ](https://dev.akarinext.org/yupix/INTSL)の為更新が遅い可能性があります。

## 公式WIKI
公式のドキュメントは[ここ](https://github.com/yupix/INTSL/wiki)で閲覧が可能です。

## このProjectに関して
本Projectの大幅な機能などはyupixが作成しております。
本Project内に存在するAWKの管理などをsousuke0422さんがおこなっています。
次に、本Projectでは[JMusicBot](https://github.com/jagrosh/MusicBot/releases)を使用しております。
JMusicBotの作者様、その他の関係者様等の方々がいて
成り立っている物です、そのあたりをご理解の上、お使いください。

## 動作環境
本Projectではechoに色を付ける際-eを使用しているため、Dashなどのターミナルを使用している場合、
本来色がつくはずの所が、そのまま -eと出力されてしまう可能性があります。

### 必須パッケージ等
- pwgen  
  ```
  Arch: sudo pacman -S pwgen  
  Ubuntu: sudo apt install pwgen  
- screen  
  ```
  Arch: sudo pacman -S screen  
  Uubntu: sudo apt install screen  
### OS
- [Ubuntu](https://www.ubuntulinux.jp/)  
- [MANJARO](https://manjaro.org/)  
- [Windows 10](https://www.microsoft.com/ja-jp/software-download/windows10)  

### JAVA
- [Amazon Corretto 8](https://docs.aws.amazon.com/ja_jp/corretto/latest/corretto-8-ug/downloads-list.html)

### Shell
現在最低限で動作確認が行えるものです。
※非推奨が付いている物は正常に動作しない可能性があります。
- zsh
- Bash
- Dash ※非推奨

## 使い方
### Linux:
<details>
<summary>詳細</summary>
このProjectではREADMEの上のほうにある
必須パッケージを必ず入れてください。

### このProjectをGitCloneする / 実行権限の付与
```
  #GitHub
  git clone git@github.com:yupix/INTSL.git
  #GitLab
  git clone git@dev.akarinext.org:yupix/INTSL.git

  #Cloneしたファイルに移動
  cd INTSL

  #実行権限の付与
  chmod +x linux.sh
```

### 動作をテストする
```
  #INTSLファイル内にいない場合は
  cd INTSL

  ./linux.sh
```
これでINTSLと大きく表示されれば正常です。
お疲れさまでした。
</details>


### Windows:
準備中

## author
- [MainSYSTEM / yupix](https://github.com/yupix/)
- [SubSYSTEM / sousuke0422](https://github.com/sousuke0422/)

## Minecraftバージョン対応状況
現在Minecraftのサーバー系でどこまでのバージョンが対応してるのかが確認できます。
※書いてあるバージョンが対応済みのバージョンです
<details>
<summary>OfficialServer</summary>


|   |   |   |   |
|---|---|---|---|
|1.2.5  |1.3.1  |1.3.2  |1.4.2  |
|1.4.4  |1.4.5  |1.4.6  |1.4.7  |
|1.5.1  |1.5.2  |1.6.1  |1.6.2  |
|1.6.4  |1.7.2  |1.7.5  |1.7.6  |
|1.7.7  |1.7.8  |1.7.9  |1.7.10  |
|1.8  |1.8.1  |1.8.2  |1.8.3  |
|1.8.4  |1.8.5  |1.8.6  |1.8.7  |
|1.8.8  |1.8.9  |1.9  |1.9.1  |
|1.9.2  |1.9.3  |1.9.4  |1.10  |
|1.10.1  |1.10.2  |1.11  |1.11.1  |
|1.11.2  |1.11.2  |1.12  |1.12.1  |
|1.12.2  |1.13  |1.13.1  |1.13.2 |
|1.14  |1.14.1  |1.14.2 |1.14.3  |
|1.14.4  |1.15 |1.15.1  |1.15.2  |
</details>
<details>
<summary>spigotServer</summary>
1.8以前のバージョンはBuildに必要なファイルをspigotがホストを
既に終了している為、Buildに失敗するため、対応する予定は現在ありません。

1.8
1.8.1
1.8.2
1.8.3
1.8.4
1.8.5
1.8.6
1.8.7
1.8.8
1.8.9
1.9
1.9.1
1.9.2
1.9.3
1.9.4
1.10
1.10.1
1.10.2
1.11
1.11.1
1.11.2
1.12
1.12.1
1.12.2
1.13
1.13.1
1.13.2
1.14
1.14.1
1.14.2
1.14.3
1.14.4
1.15
1.15.1
1.15.2
1.16
</details>
<details>
<summary>PaperServer</summary>
|   |   |   |   |
|---|---|---|---|
|1.7.10 |1.8.8  |1.9.4  |1.10.2  |
|1.11.2 |1.12.2  |1.13.2  |1.14.4  |
|1.15.2 |  |  |  |
対応済み
記載については後日
</details>

## SpecialThanks
本Projectを作るきっかけとなった物です、この場で心より感謝申し上げます。
[JMusicBot](https://github.com/jagrosh/MusicBot/releases)

## このプロジェクトを使う際の注意点
 - 概要
 - GitCloneして使用する際の注意点
 - 2時配布について
<details>
<summary>詳細</summary>

### 概要
まず最初に、このProjectを本番環境での使用は現在
推奨されません。理由としてはこのProjectは主に2人で
開発・テストが行われているため、見逃し等で重大なバグ等を
誤って最新バージョンでリリースしてしまう可能性があるためです。

### このProjectをGitCloneして使う際の注意点
このProjectは特定の行に文字を追加する処理等が多数存在し、
Releasesではなく、普通にGitCloneした場合その行がずれている事があります。
もし、ずれている物を使用すると99%の確率で動作がおかしくなる可能性があります。
そのため、開発者以外はReleasesからのダウンロードをお勧めします。

### ２時配布に関して
本Projectでは
その他、改造された物などは、yupixによって追加された機能以外が存在する可能性があるため、
今永久的なサポートを受けるには本Projectの2次配布をお控えください。ご協力お願いします
</details>

## 拡張機能について
このProjectでは拡張機能が使用可能となっています。
現在公式で開発している拡張機能をインポートする方法は以下の通りです。
※INTSLは既にInstallされている事を想定しています。
※現在このRepositoryは空の為使用することができません。
<details>

## 拡張機能をgitcloneする
```
git clone https://dev.akarinext.org/yupix/intsl-on-mindustry.git
```
## 中にあるmindustry.shをINTSLのlinux.shがある所までもっていく(ProjectRoot)

## 導入する為に以下の行を1行ずつ実行します。
※>は消してください
```
./linux.sh main
> extension
> import
> mindustry
```

## 使えるか確認する
```
./linux.sh main
> extension
> use
> mindustry
> start
```
</details>

## 開発者モードの有効化
以前まではパスワードは全ShellScript共通でしたが、今回から
ダウンロードされた方々の環境でパスワードが生成されるようになりました。
現在開発者モードはテスト段階の為、動作が不安定な可能性が高いです。
それをご理解の上ご利用ください。
開発者モードを有効化するには以下の手順を踏む必要があります。
※">"は消します
```
./linux.sh main
> dev
#様々な物が出力されたのち
パスワードの生成にしました。パスワードは以下の通りです。
パスワード: □□□□□□□□□□□
パスワードは変更可能の為、ご自分で変更する事が可能です。

その後パスワード入力で□□□□□□の部分に入るものを入力すると有効化が可能です。
```


## サポート
バグの発見または機能の追加に付きましては以下のページ等に報告していただけると助かります。
Issuesは確認までに時間がかかると思われます、早めの対応を
望む場合はDiscordへの参加を推奨します。
- [Discord](https://discord.gg/uDNyePY)
- [issues](https://github.com/yupix/amb/issues)

## ライセンス
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="クリエイティブ・コモンズ・ライセンス" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br /><a xmlns:cc="http://creativecommons.org/ns#" href="https://dev.akarinext.org/yupix/INTSL/-/blob/dev/credit.md" property="cc:attributionName" rel="cc:attributionURL">TEAM YUPIX</a> 作『<span xmlns:dct="http://purl.org/dc/terms/" href="http://purl.org/dc/dcmitype/Text" property="dct:title" rel="dct:type">INTSL</span>』は<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">クリエイティブ・コモンズ 表示 - 継承 4.0 国際 ライセンス</a>で提供されています。<br /><a xmlns:dct="http://purl.org/dc/terms/" href="https://dev.akarinext.org/yupix/INTSL/" rel="dct:source">https://dev.akarinext.org/yupix/INTSL/</a>にある作品に基づいている。

- JmusicBot
  - [![License](https://img.shields.io/badge/license-Apache%202-blue)](https://github.com/jagrosh/MusicBot/blob/master/LICENSE)
