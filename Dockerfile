# 最新の安定版イメージを使用
FROM m1k1o/neko:chromium

USER root

# 1. 必要なツール（curl, cloudflared）のインストール
RUN apt-get update && apt-get install -y curl
RUN curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && rm cloudflared.deb

# 2. Renderの無料枠（512MB）で動作するように環境変数を設定
ENV NEKO_PORT=10000
ENV NEKO_PASSWORD=123456
ENV NEKO_BIND=:10000

# Renderが外からチェックしに来るポートを空けておく
EXPOSE 10000

# 3. 起動コマンド
# Renderが「ポートが開いた」と即座に認識できるようにしつつ、
# 裏でフィルタ回避用のトンネル（Cloudflare）を立ち上げる
CMD /usr/bin/neko serve --bind :10000 & sleep 5 && cloudflared tunnel --url http://localhost:10000
