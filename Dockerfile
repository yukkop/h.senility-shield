FROM alpine:3.14

RUN apk add --no-cache bash curl

WORKDIR /app

COPY . .

CMD ["bash", "birthday_notifier.sh"]
