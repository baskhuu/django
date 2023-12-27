# python3のイメージからイメージを開始する
FROM python:3

# pythonのエラー出力関連の設定のようです
ENV PYTHONUNBUFFERED=1

# アプリケーションを配置するフォルダを指定する
WORKDIR /usr/src/app

# ローカルから、Docker内のカレントディレクトリへファイルをコピー
COPY requirements.txt ./

# 入れ直すために一回アンインストール
RUN pip uninstall django

# 必要なパケージをインストール
RUN pip install -r requirements.txt