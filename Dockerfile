# 最新の動作確認済みイメージに変更
FROM m1k1o/neko:chromium

USER root

# フィルタ回避用の cloudflared をインストール
RUN apt-get update && apt-get install -y curl
RUN curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && rm cloudflared.deb

# Renderのメモリ制限に合わせて設定（512MBに最適化）
ENV NEKO_PORT=10000
ENV NEKO_PASSWORD=123456
ENV NEKO_BIND=:10000

EXPOSE 10000

# nekoを起動し、5秒後に「秘密のURL」を発行する
CMD /usr/bin/neko & sleep 5 && cloudflared tunnel --url http://localhost:10000
