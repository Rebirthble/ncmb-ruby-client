ncmb-ruby-gateway
================

A simple Ruby gateway for the nifty cloud mobile backend REST API

Getting Started
------------

リポジトリをcloneします

```
$git clone https://github.com/Rebirthble/ncmb_ruby_gateway.git
```

gemをインストールします

```
$bundle install
````

setting.ymlを作成してニフティクラウド mobile backendのAPIキーを設定します

```
application_key: YOUR_APP_KEY 
client_key: YOUR_CLI_KEY
```

ローカルで実行してみます

```
$bundle exec rackup config.ru -p 31614
```

ブラウザで http://localhost:31614 にアクセスしてみてください

Not Foundが出て来ます(APIのパスを指定していないため)

この状態で、サーバーに対してAPIリクエストを実行してみてください

JSONデータが返ってくるとmobile backendへの通信が行われていることになります

```
//Object registration API
$curl -X POST -d '{"title":"fugafuga"}' 'http://localhost:31614/classes/aaaa'
{"createDate":"2015-01-23T12:18:09.858Z","objectId":"OqlyCn0vNyp64i4m"}
```

Herokuへのデプロイ
-----------------

(Herokuのアカウント登録、CLIツールの用意が終わった状態から始まります)

リポジトリ直下でheroku createを実行します

```
$heroku create
```

HerokuへのリモートリポジトリURLが追加されるので、pushをします。

```
$git push heroku master
```

ローカルではsetting.ymlを用意してAPIキーを設定しましたが、

pushしてはいけないものなので、Config Variablesを利用してAPIキーを設定してください

環境変数名は以下の二つを利用してください。

```
NCMB_APPLICATION_KEY
NCMB_CLIENT_KEY
```

heroku open コマンドを実行するとデプロイ先のURLが分かるので、URLをコピーします

```
$heroku open
```

ローカルに対して実行していたcurlをコピーしたURL(=デプロイ先)に対して実行します

```
$ curl -X POST -d '{"title":"fugafuga"}' 'https://your-heroku-app.herokuapp.com/classes/aaaa'
{"createDate":"2015-01-23T12:25:45.568Z","objectId":"Yjf84wPstWoV15tH"}
```

使い方
------

REST APIのリクエスト方法は、ほぼ以下のREST APIリファレンスに準拠しています

このgatewayに対して、JSONデータを送信してJSONデータを受け取ってください

ただし、データ検索を行う場合のみ、上記のサンプルを参考にクエリストリングはURLエンコードした状態でリクエストしてください

[REST APIリファレンス](http://mb.cloud.nifty.com/doc/rest/common/format.html)

対応している機能は以下の通りです。

- データストア

[ニフティクラウド mobile backend](http://mb.cloud.nifty.com/)
