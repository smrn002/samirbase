# Use Alpine x86_64
FROM alpine:latest

# Install dependencies
RUN apk add --no-cache bash ca-certificates unzip

# Copy AMD64 PocketBase binary
COPY pocketbase /pb/pocketbase
RUN chmod +x /pb/pocketbase

# Persistent data
RUN mkdir -p /pb_data
EXPOSE 8080

# Admin account
ENV ADMIN_EMAIL="admin@example.com"
ENV ADMIN_PASSWORD="YourSecurePassword"
ENV ADMIN_NAME="Admin"

# Start PocketBase
CMD bash -c "/pb/pocketbase admin create --email $ADMIN_EMAIL --password $ADMIN_PASSWORD --name '$ADMIN_NAME' --ignore-existing && /pb/pocketbase serve --http=0.0.0.0:8080 --dir /pb_data"