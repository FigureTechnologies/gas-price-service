FROM nginx:1.21.6-alpine

ENV GAS_PRICE 19050
ENV GAS_PRICE_DENOM nhash

LABEL org.opencontainers.image.source=https://github.com/provenance-io/gas-price-service

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./gas-prices.json.template /usr/share/nginx/html/gas-prices.json.template
COPY ./gas-prices.coin.json.template /usr/share/nginx/html/gas-prices.coin.json.template

CMD [ "sh", "-c", "\
    envsubst < /usr/share/nginx/html/gas-prices.json.template > /usr/share/nginx/html/gas-prices.json \
    && envsubst < /usr/share/nginx/html/gas-prices.coin.json.template > /usr/share/nginx/html/gas-prices.coin.json \
    && nginx -g 'daemon off;'\
" ]