FROM alpine:latest

ARG PB_VERSION=0.29.3

RUN apk add --no-cache bash ca-certificates unzip

# Download AMD64 binary directly
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/ && chmod +x /pb/pocketbase

# Create persistent data folder
RUN mkdir -p /pb_data
EXPOSE 8080

# Superuser credentials
ENV SUPERUSER_EMAIL="admin@example.com"
ENV SUPERUSER_PASSWORD="YourSecurePassword"

# Start PocketBase and create superuser if not exists
CMD bash -c "/pb/pocketbase superuser upsert $SUPERUSER_EMAIL $SUPERUSER_PASSWORD && /pb/pocketbase serve --http=0.0.0.0:8080 --dir /pb_data"