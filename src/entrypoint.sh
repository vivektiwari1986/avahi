#!/bin/bash

# Start the Avahi daemon
/usr/sbin/avahi-daemon --daemonize

# Create Python script to read aliases and publish them
cat > /app/publish_aliases.py << 'EOF'
#!/usr/bin/env python3
import os
import sys

def read_aliases(filepath):
    if not os.path.exists(filepath):
        print(f"Error: Aliases file {filepath} not found")
        sys.exit(1)
        
    with open(filepath, 'r') as f:
        return [line.strip() for line in f if line.strip()]

def main():
    aliases_file = '/config/mdns-aliases'
    aliases = read_aliases(aliases_file)
    
    if not aliases:
        print("No aliases found in config file")
        sys.exit(1)
    
    cmd = ['/opt/venv/bin/mdns-publish-cname'] + aliases
    os.execv('/opt/venv/bin/mdns-publish-cname', cmd)

if __name__ == '__main__':
    main()
EOF

chmod +x /app/publish_aliases.py

# Activate virtual environment and run the publisher script
. /opt/venv/bin/activate
exec python3 /app/publish_aliases.py
