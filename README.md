## Melody Map



## サービス概要
アーティストにゆかりのある場所（ミュージックビデオのロケ地、サインがあるお店など）を検索、投稿できるCGM形式のアプリです。アーティストや地域で検索する機能を実装することでゆかりの地を調べられるようにし、ファンの方々が聖地巡礼を楽しむことをサポートします。また訪れた場所で撮った写真を投稿できるようにすることで実際にその場所を訪れずとも他のユーザーが投稿した写真を通じて楽しむこともできます。



## このサービスへの思い・作りたい理由
一部のアーティストの熱狂的なファンの中にはミュージックビデオの撮影に使用された場所や、サインがあるお店を巡って写真撮影などをして楽しんでいる人がいます。私自身、BUMP OF CHICKENというロックバンドの楽曲を１０年以上好んで聴いており、彼らのサインがあることで有名なお好み焼き屋さんや撮影に使われた場所を訪れた経験があります。しかしながら彼らの代表曲である「天体観測」の撮影に使われた多摩川団地の給水塔は老朽化により取り壊されてしまったため、地元の近くにあったにも関わらず訪れることができませんでした。このような経験から、アーティストにゆかりのある地域を簡単に調べて訪れることをサポートしたり、そのとき撮った写真を投稿して記録として残せるアプリがあったら良いのではないかと考えました。私としてはこのアプリがニッチなジャンルに特化したお出かけアプリとして使用され、ユーザーがより深く音楽を楽しむきっかけとなることを願っています。



## ユーザー層について
- 特定のアーティストの熱狂的なファン

「アーティスト名　聖地巡礼」や「楽曲名　撮影地」などで検索するとその楽曲の撮影に使用された場所を巡って楽しんでいる方のブログなどが出てきます。
現状このような方々をターゲットとしたアプリは見つけることができなかったためターゲットとしました。



## サービスの利用イメージ
- 旅行記録系のアプリと同じようにユーザーがアーティストにゆかりのある地を訪れた際の記録を投稿することができます。
  また他のユーザーが保存した地図データからアプリ内で場所を調べて巡礼することをサポートします。

- 他のユーザーの投稿を通じてミュージックビデオのロケ地やサインを見ることができます。
  この機能によりアーティストのロケ地やサインのあるお店を知ることが出来たり、ミュージックビデオ内では編集されて綺麗に見える場所の違った見え方を楽しむことができます。



## ユーザーの獲得について
X（旧Twitter）を使用して宣伝を行います。
聖地一覧に可能な限り初期データを用意することでユーザーに興味を持ってもらえるようにします。



## サービスの差別化ポイント・推しポイント
- 競合アプリとの差別化ポイント

類似サービスとしては旅行の記録を投稿するアプリが挙げられますが、それらのサービスとの差別化ポイントはアーティストにゆかりのある場所に焦点を当てたところです。
旅行先で撮った写真や出来事を記録するアプリは複数存在しますが、その中でもアーティストに焦点を当てたアプリは見受けられませんでした。
このアプリではアーティストにゆかりのある地を調べて訪れてみたり、他の人の投稿を通じてミュージックビデオに映ってるのとはまた違った見え方を楽しむことができます。


- 推しポイント

YouTubeにアップロードされている公式ミュージックビデオを埋め込むことによりミュージックビデオ内で実際に使用されているところをこのアプリ内で確認することができます。



## 機能候補
- MVPリリース
  - 会員登録
  - ログイン、ログアウト
  - 聖地機能
    - 聖地一覧機能
      - ブックマーク機能
    - 聖地詳細表示
    - 聖地投稿機能（ミュージックビデオのロケ地、サインのあるお店、その他でタグ付け）
    - 聖地編集機能
  - 一つ一つの聖地に対する投稿機能
    - 投稿一覧表示機能
    - 投稿詳細表示（マップ表示）
    - 投稿機能（タイトル、テキスト、画像、地図座標を保存できるようにする）
    - 投稿編集機能
    - 投稿削除機能
  - 検索機能（オートコンプリート）
    - 聖地検索（アーティスト名、タグの種類）
    - 投稿検索（アーティスト名、地域）
- 本リリース
  - レスポンシブデザイン
  - MiniMagicでユーザーの投稿写真を画像加工
  - YouTubeに公開されているアーティストの公式ミュージックビデオを聖地詳細画面に埋め込む機能（著作権に反した動画を投稿されることを防ぐため管理画面からのみ）



## 機能の実装方針予定
- バックエンド
  - Ruby 3.2.2
  - Ruby on Rails 7.1.2
- フロントエンド
  - JavaScript
  - Tailwind CSS
- デプロイ
  - Heroku
- API
  - Google Maps JavaScript API
  - Google Maps Geocoding API



## 画面遷移図（後日修正予定）
https://www.figma.com/file/6inHsr10Oe0pJ7KbgZn5Zs/music_map?type=design&node-id=0-1&mode=design&t=0BVngzIhOdUOHUUH-0


## ER図
[![Image from Gyazo](https://i.gyazo.com/66af4d8cd79fdd161f28dc56c51d2d4e.png)](https://gyazo.com/66af4d8cd79fdd161f28dc56c51d2d4e)
