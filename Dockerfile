FROM alpine:latest
RUN apk add --no-cache bash ca-certificates unzip

ARG PB_VERSION=0.29.3
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/ && chmod +x /pb/pocketbase

RUN mkdir -p /pb_data
EXPOSE 8080

ENV ADMIN_EMAIL="admin@example.com"
ENV ADMIN_PASSWORD="YourSecurePassword"
ENV ADMIN_NAME="Admin"

CMD bash -c "/pb/pocketbase admin create --email $ADMIN_EMAIL --password $ADMIN_PASSWORD --name '$ADMIN_NAME' --ignore-existing && /pb/pocketbase serve --http=0.0.0.0:8080 --dir /pb_data"