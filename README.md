ncmb-ruby-gateway
================

A simple Ruby gateway for the nifty cloud mobile backend REST API

必要なもの
-------

- Ruby v2.1.x~
- Sinatra

インストール手順
------------

```
$gem install sinatra
```

```
$git clone https://github.com/Rebirthble/ncmb_ruby_gateway.git
```

Basic Usage
-----------

setting.ymlを開いて、mobile backendのAPIキーを登録してください。

```
application_key: YOUR_APP_KEY 
client_key: YOUR_CLI_KEY
```

gateway.rbを実行します。

```
$ruby gateway.rb
```

この状態で、サーバーに対してAPIリクエストを実行してみてください。
以下のcurlコマンドのサンプルのように、APIキーでの認証をgatewayが担ってくれます。

```
//Object registration API
curl -X POST -d '{"title":"fugafuga"}'  http://localhost:4567/classes/aaaa

//Object search API
curl 'http://localhost:4567/classes/aaaa?where=%7b%22title%22%3a%22test%22%7d&limit=10'

```

REST APIのリクエスト方法は、ほぼ以下のREST APIリファレンスに準拠しています。
JSONデータを送信して、JSONデータを受け取ってください。
ただし、データ検索を行う場合のみ、上記のサンプルを参考にクエリストリングはURLエンコードした状態でリクエストしてください。

[REST APIリファレンス](http://mb.cloud.nifty.com/doc/rest/common/format.html)

対応している機能は以下の通りです。

- データストア

[ニフティクラウド mobile backend](http://mb.cloud.nifty.com/)
