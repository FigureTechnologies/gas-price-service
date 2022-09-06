FROM golang:1.18 as go
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest

WORKDIR /coinconvert

ADD ./go /coinconvert

RUN go install /coinconvert

FROM nginx:1.21.6-alpine

ENV GAS_PRICE 19050
ENV GAS_PRICE_DENOM nhash

LABEL org.opencontainers.image.source=https://github.com/FigureTechnologies/gas-price-service

COPY --from=go /go/bin/coin-json-to-proto /usr/bin/coin-json-to-proto

COPY ./nginx.conf /etc/nginx/conf.d/default.conf
COPY ./gas-prices.json.template /usr/share/nginx/html/gas-prices.json.template
COPY ./gas-prices.coin.json.template /usr/share/nginx/html/gas-prices.coin.json.template

CMD [ "sh", "-c", "\
    envsubst < /usr/share/nginx/html/gas-prices.json.template > /usr/share/nginx/html/gas-prices.json \
    && envsubst < /usr/share/nginx/html/gas-prices.coin.json.template > /usr/share/nginx/html/gas-prices.coin.json \
    && coin-json-to-proto < /usr/share/nginx/html/gas-prices.coin.json > /usr/share/nginx/html/gas-prices.coin.bin \
    && nginx -g 'daemon off;'\
" ]