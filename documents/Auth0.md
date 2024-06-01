# Auth0の設定ガイド

## Auth0のテナントを作成する
- TENANT DOMAIN
  - 以降変更できないので、production用はアプリのドメインに合わせる
  - Auth0でログインする時のURLが「xxx.jp.auth0.com」になる
- REGION: 日本

cf: https://auth0.com/signup/?utm_source=devcenter&utm_medium=auth0&utm_campaign=devn_signup

## フロントのアプリケーション設定
遷移
- Applications -> Applications

設定
- Create Application
  - Application Type: Regular Web Applications
  - Domain, Client ID, Client Secretは.envで使用する
  - Application Logo: 使用箇所は不明
  - Allowed Callback URLs: https://xxx/api/auth/callback
  - Allowed Logout URLs: ログアウト後に表示するURLで、同一ドメインならどこでもよい

## front/.envの設定
- AUTH0_SECRET=（`node -e "console.log(crypto.randomBytes(32).toString('hex'))"`で作成）
- AUTH0_BASE_URL=http://localhost:8002
- AUTH0_ISSUER_BASE_URL=（Domainを記載）
- AUTH0_CLIENT_ID=（Client IDを記載）
- AUTH0_CLIENT_SECRET=（Client Secretを記載）

## ユニバーサルログインの設定
GitHubに遷移させてるので不要かも  
  
遷移
- Branding -> Universal Login -> Advanced Options

設定
- Universal Login Experience: New
- Save Changes

### （参考）ログイン画面のカスタマイズ  
  
遷移
- Branding -> Universal Login -> Customization Options

変更できる内容
- ロゴ
- 色
- フォント等

ログイン画面のイメージ

<img src="https://i.gyazo.com/33f7a8646cd5d4b7289c8220a77adaba.png" width="200px">

Advanced Optionsから直接HTMLを編集することもできそう


# （参考）無料枠の範囲
- ユニバーサルログイン
- 外部ログイン（最大２つ）
- アクション、ルール、フックのカスタマイズ（最大３つ）
- １つのテナント＝developmentとproductionを切り替え不可
- アクティブユーザー数：7000人
- M2M認証（＝バックエンドAPIの認証）：1000
- 管理者ユーザ：3人


cf: https://developer.auth0.com/resources/guides/web-app/nextjs/basic-authentication#quick-next-js-setup
