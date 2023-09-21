# stamp_app

## サービス概要
作成したスタンプラリーを共有して
共有した相手に現地をおもむかせる
イベント作成サービスです。

## 想定されるユーザー層
- スタンプラリーを作りたい方
- スタンプラリーをしたい方

## サービスコンセプト
幼少期に、北海道の道の駅を回ってスタンプを集めていたことが楽しかったため、
自由に個人でスタンプラリーを作成し、スタンプを集めることができるサービスを考案しました。
例えば、美味しいカレー屋さんが複数店あるから行って欲しいという時に
スタンプの設置場所を設定し、全体に公開もしくは、行って欲しい方に
そのスタンプラリーを送りつけることができます。
個人でスタンプラリーを作成、公開し、そのスタンプラリーをインターネット上で
遊ぶことができるサービスはなかなかないのではないでしょうか。
このアプリケーションの売りは、スタンプラリーを個人が作れるだけでなく、
集めるスタンプを独自に作成できるところにあります。
「この人が作ったスタンプが気になる！」とスタンプ集めに夢中になれるところも売りどころです。

## 実装予定の機能
### MVP
- ユーザー登録
  - 通常
    - ユーザー名
    - メールアドレス
    - パスワード
  - Google認証
- ユーザー登録後
  - ユーザー編集
    - ユーザー名
  - スタンプラリー
    - 作成、編集、削除
      - スタンプ設置位置の設定（1〜7個）JSによりフォームの個数を制限
        - スタンプの登録
      - 公開範囲の設定
        - 全体
        - 非公開（リンクのみでシェアが可能）
    - 一覧
      - 全体公開
      - 自身が作成したもの
      - 参加しているもの
    - 検索
      - 全体公開のみ
    - 詳細
      - 参加
      - Twitterでのシェアボタン
  - スタンプ集（ゲットしたスタンプの表示ページ）
- 管理ユーザー
  - ユーザー：一覧、詳細、編集、削除
  - スタンプラリー：一覧、詳細、削除

### その後の機能
* タグ機能
* スタンプラリーのタグ機能
* スタンプラリーの検索機能（indexのタブごと）
* スタンプ集のページネーション
* 参加したスタンプラリーからのレコメンド機能
* RSpecの現在読んでいる本が終わり次第、テストを作成する
* OGPの追加

## スケジュール
README〜ER図作成：07/16 〆切
メイン機能実装：07/17 - 09/17
β版をRUNTEQ内リリース（MVP）：9月末〆切
本番リリース：10月中

## 技術選定
- Rails7
- Hotwire
- postgresql
- JavaScript
- Bootstrap
- heroku
- Google Maps Geolocation API
- Google Maps Geocording API
- Google Places API
- GCP Recommendations AI（MVP後）
- Sweetalert2
- importmap
- AWS S3（画像保存）
- パスワードリセット機能

---
## 画面遷移図
https://www.figma.com/file/nb2HTfN6mYQ9h3xUFlQayB/%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E5%9B%B3?type=design&node-id=0%3A1&mode=design&t=YRlf4E5iQV4eIPDB-1

[![Image from Gyazo](https://i.gyazo.com/41a4738130ffac57a28ed8772c572f91.png)](https://gyazo.com/41a4738130ffac57a28ed8772c572f91)

---
## ER図
https://drive.google.com/file/d/1Xvk63R1wjcOWkJg6fzSLOHmgwmkRANpK/view?usp=sharing

[![Image from Gyazo](https://i.gyazo.com/4eb478485288afdb6666f93d30defd9c.png)](https://gyazo.com/4eb478485288afdb6666f93d30defd9c)

### 概説
- Autenticates
  - provider：サービスのプロバイダー名
  - uid
- StampRallies
  - image：サムネイル
  - area：公開範囲指定（のちに下書きも追加予定）
    全体に作成したスタンプラリーを公開するか否か
- Stamps
  - name：場所の名前（例：店名）
  - sticker：スタンプラリーでゲットできるスタンプの画像
- PaticipantsStamps
  participant（スタンプラリーの参加者）がスタンプ設置場所に出向いた際にスタンプを格納します。
  - participant_id：participantsテーブルのidを格納
  - stamp_id：スタンプラリーの設置場所により、スタンプの種類（stampsテーブルのstickerカラム）が異なる可能性があるため、stampテーブルから外部キーで参照しております。
