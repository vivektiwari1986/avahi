# Dockerfile
FROM alpine:latest

# Install required packages
RUN apk add --no-cache \
    python3 \
    python3-venv \
    py3-pip \
    avahi \
    avahi-tools \
    dbus \
    bash

# Create and activate virtual environment
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install Python mDNS publisher in virtual environment
RUN . $VIRTUAL_ENV/bin/activate && pip install mdns-publisher

# Create directory for scripts and config
RUN mkdir -p /app

# Create entrypoint script
COPY entrypoint.sh /app/
RUN chmod +x /app/entrypoint.sh

# Set working directory
WORKDIR /app

# Default command
ENTRYPOINT ["/app/entrypoint.sh"]
