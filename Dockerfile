FROM vimagick/neko:chromium

USER root
# フィルタ回避用のツールをインストール
RUN apt-get update && apt-get install -y curl
RUN curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && rm cloudflared.deb

ENV NEKO_PORT=10000
ENV NEKO_PASSWORD=123456
ENV NEKO_BIND=:10000

# 起動時に「誰にもバレない一時的なURL」を発行する
CMD /usr/bin/neko & sleep 5 && cloudflared tunnel --url http://localhost:10000
