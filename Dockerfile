# ブラウザ専用の軽量イメージ
FROM vimagick/neko:chromium

# Renderの無料枠に合わせて設定
ENV NEKO_PORT=10000
ENV NEKO_PASSWORD=123456
ENV NEKO_BIND=:10000

# ポートの開放
EXPOSE 10000

# 起動コマンド
CMD ["/usr/bin/neko"]
