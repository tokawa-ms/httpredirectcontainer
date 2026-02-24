# HTTP Redirect Container 🔀

![Docker](https://img.shields.io/badge/Docker-ready-2496ED?logo=docker&logoColor=white)
![Nginx](https://img.shields.io/badge/Nginx-alpine-009639?logo=nginx&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

環境変数 `REDIRECT_TO` で指定したURLへ **301 Redirect** を返す、軽量な nginx コンテナーです。

## ✨ 特長

- `REDIRECT_TO` だけでリダイレクト先を切り替え
- パス・クエリを保持して転送（例: `/en-us?a=1`）
- `301 Moved Permanently` 固定
- シンプル構成（`Dockerfile` + nginx template）

## 🧠 仕組み

```mermaid
flowchart LR
    A[Client Request\nhttp://localhost:8080/en-us?x=1] --> B[Nginx Container]
    B --> C[return 301\n${REDIRECT_TO}$request_uri]
    C --> D[https://www.microsoft.com/en-us?x=1]
```

## 📦 ファイル構成

- `Dockerfile`: nginx イメージ定義
- `nginx.conf.template`: 301 リダイレクト設定
- `docker-compose.yml`: ローカル実行用設定
- `LICENSE`: MIT

## 🚀 使い方

### 1. イメージをビルド

```bash
docker build -t httpredirect .
```

### 2. 起動

```bash
docker run -p 8900:80 -e REDIRECT_TO=https://www.microsoft.com httpredirect
```

### 3. 確認

```bash
curl -I http://localhost:8900/en-us
```

期待されるレスポンス:

- `HTTP/1.1 301 Moved Permanently`
- `Location: https://www.microsoft.com/en-us`

## 🧪 Docker Compose（開発向け）

`docker-compose.yml` は以下の通り、ローカル限定公開になっています。

- `127.0.0.1:8080:80`

実行:

```bash
docker compose up --build
```

## 🔐 セキュリティメモ

- `REDIRECT_TO` は信頼できる固定URLを使用してください
- 本番公開時は `REDIRECT_TO` を運用設定で厳格管理してください
- ベースイメージは必要に応じてバージョン/ダイジェスト固定を推奨

## 📄 ライセンス

MIT License (`LICENSE`)
