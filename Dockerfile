# Use Alpine as a lightweight base
FROM alpine:latest

# Install dependencies
RUN apk add --no-cache bash ca-certificates

# Copy PocketBase binary into container
COPY pocketbase /pb/pocketbase

# Make binary executable
RUN chmod +x /pb/pocketbase

# Create a directory for persistent data
RUN mkdir -p /pb_data

# Expose port 8080
EXPOSE 8080

# Set environment variables for admin account
ENV ADMIN_EMAIL="admin@example.com"
ENV ADMIN_PASSWORD="YourSecurePassword"
ENV ADMIN_NAME="Admin"

# Start PocketBase and create admin automatically if not exists
CMD bash -c "/pb/pocketbase admin create --email $ADMIN_EMAIL --password $ADMIN_PASSWORD --name '$ADMIN_NAME' --ignore-existing && /pb/pocketbase serve --http=0.0.0.0:8080 --dir /pb_data"