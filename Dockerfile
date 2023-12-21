# python3のイメージからイメージを開始する
FROM python:3

# pythonのエラー出力関連の設定のようです
ENV PYTHONUNBUFFERED=1

# アプリケーションを配置するフォルダを指定する
WORKDIR /usr/src/app

# Copy local directories to the current local directory of our docker image (/app)
COPY requirements.txt ./
RUN pip uninstall django
RUN pip install -r requirements.txt