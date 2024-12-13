# Dockerfile
FROM alpine:latest

# Install required packages
RUN apk add --no-cache \
    python3 \
    py3-pip \
    avahi \
    avahi-tools \
    dbus \
    bash

# Install Python mDNS publisher
RUN pip3 install mdns-publisher

# Create directory for scripts and config
RUN mkdir -p /app

# Create entrypoint script
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

# Set working directory
WORKDIR /app

# Default command
ENTRYPOINT ["/app/entrypoint.sh"]
