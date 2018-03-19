# Grouping_bot

## 概要
チーム分けがめんどうなので作成しました。

## Bot起動
ここらへん読んで、rubyインスコ→devkitのインスコ→discordrbのインストールまで行ってください。
因みに、`gem install discordrb --platform=ruby`じゃなくても、`gem install discordrb`でもインストール出来ることは確認済み
- [Discord Bot の 簡単な作り方](https://asamacs.wordpress.com/2016/06/22/discord-bot-の-簡単な作り方/)
- [ruby入門者がdiscordのbotで遊んだ話](http://qiita.com/butaman551/items/7710113c0771cff05bbe)
- [rubyで作ったdiscordbotをherokuにデプロイする話](http://qiita.com/butaman551/items/eba0a5da386194e4306c)

## 使い方
まずは自分のコマンドプロンプトでgrouping.rbがあるディレクトリまで移動し、`grouping.rb`で起動させてください。
又は誰かが起動させればいいと思います。

以下は主なアクション

`/add プレイヤー名`
- プレイヤーをシャッフルリストに追加

`/clear`
- シャッフルリストの初期化

`/grouping`
- シャッフル開始

`/hi`
- ポプ子の可愛い画像が届きます

`?oni oni_number`
- 鬼ごっこの人選決め
  - oni_number : 鬼の数
    - 1: スレッジ
    - 2: スレッジ・ツイッチ
    - 3: スレッジ・ツイッチ・ブリッツ

## ポプ子の可愛い画像
`img`ディレクトリ内の画像がランダムで一枚表示されます。

## heroku
- `git push heroku master` herokuアップロード
- `heroku ps:scale worker=1` 起動
- `heroku ps:scale worker=0` 停止
