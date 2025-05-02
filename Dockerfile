FROM nginx:alpine

# Hello Worldのシンプルなページを作成
RUN echo '<html><body><h1>Hello World</h1><p>GitHub Actions Cache Test</p></body></html>' > /usr/share/nginx/html/index.html

# ヘルスチェック用の設定
HEALTHCHECK --interval=30s --timeout=3s \
  CMD wget --no-verbose --tries=1 --spider http://localhost:80/ || exit 1

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"] 