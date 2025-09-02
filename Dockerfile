# Use Alpine as a lightweight base
FROM alpine:latest

ARG PB_VERSION=0.29.3

# Install dependencies
RUN apk add --no-cache bash ca-certificates unzip

# Download Linux AMD64 binary of PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/ && chmod +x /pb/pocketbase

# Copy pre-populated pb_data folder
COPY pb_data /pb_data

# Expose port 8080
EXPOSE 8080

# Start PocketBase
CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080", "--dir", "/pb_data"]