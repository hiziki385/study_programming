# イメージ名を確実に存在するものに変更
FROM n0ne1/neko:chromium

USER root

# フィルタ回避用の cloudflared をインストール
RUN apt-get update && apt-get install -y curl
RUN curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && rm cloudflared.deb

# Renderのポート制約に対応
ENV NEKO_PORT=10000
ENV NEKO_PASSWORD=123456
ENV NEKO_BIND=:10000

EXPOSE 10000

# nekoを起動しつつ、Cloudflareのトンネルを掘って「別のURL」を発行する
CMD /usr/bin/neko & sleep 5 && cloudflared tunnel --url http://localhost:10000
