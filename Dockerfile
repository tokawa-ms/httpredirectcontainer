FROM nginx:alpine

# envsubst の対象を REDIRECT_TO のみに限定（nginx 変数 $request_uri が誤って空に置換されるのを防ぐ）
ENV NGINX_ENVSUBST_FILTER='REDIRECT_TO'

# テンプレートをコピー（起動時に envsubst で $REDIRECT_TO が展開される）
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

EXPOSE 80
