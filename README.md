# mDNS Publisher for Docker

This package provides a containerized solution for publishing multiple mDNS (Avahi) aliases on your local network. It's particularly useful for homelab setups where you want to access different services using `.local` domains. Note: You must have a reverse proxy solution (Traefik, ngnix) that points the xyz.local domain to the IP address and port of the hosted service. mDNS publisher will only publish DNS records for pointing xyz.local to the docker host port 80.

## Features

- Publish multiple mDNS aliases for your host
- Based on Alpine Linux for minimal image size
- Supports custom hostname configurations
- Host network integration for proper mDNS functionality

## Prerequisites

- Docker
- Docker Compose (optional)
- Linux host with network access

## Quick Start

1. Create a configuration directory:
```bash
mkdir -p config
```

2. Create an aliases file:
```bash
nano config/mdns-aliases
```

Add your desired aliases, one per line:
```
homepage.local
filebrowser.local
plex.local
```

3. Deploy using Docker Compose:

```yaml

services:
  mdns-publisher:
    build:
      # Replace with your repository path if you've forked it
      context: https://github.com/vivektiwari1986/mDNS-publisher.git#dev:src
    container_name: mdns-publisher
    network_mode: host  # Required for mDNS to work properly
    restart: unless-stopped
    volumes:
      - /opt/mDNS/config:/config
```

Save this as `docker-compose.yml` and run:
```bash
docker compose up -d
```

## Alternative Deployment (Docker CLI)

If you prefer using Docker directly:

```bash
# Build the image
docker build -t mdns-publisher https://github.com/vivektiwari1986/mDNS-publisher.git#dev:src

# Run the container
docker run -d \
  --name mdns-publisher \
  --network host \
  --restart unless-stopped \
  -v /opt/mDNS/config:/config \
  mdns-publisher
```

## Configuration

### Aliases File Format
The `mdns-aliases` file should contain one hostname per line. Each hostname should end with `.local`. For example:

```
service1.local
service2.local
dashboard.local
monitoring.local
```

### Verification

To verify your aliases are working:

1. Check container logs:
```bash
docker logs mdns-publisher
```

2. Test an alias:
```bash
ping service1.local
```

## Troubleshooting

1. If aliases aren't resolving:
   - Verify the container is running: `docker ps`
   - Check container logs: `docker logs mdns-publisher`
   - Ensure host networking is enabled
   - Verify your aliases file exists and has correct permissions

2. For container startup issues:
   - Check if avahi-daemon is running in the container
   - Verify D-Bus is functioning properly
   - Ensure no port conflicts with host avahi-daemon


## Contributing

Feel free to submit issues and pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Avahi project for providing the mDNS implementation
- Docker for containerization
- Alpine Linux for the base image
