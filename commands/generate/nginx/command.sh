#!/bin/bash

set -e

# --- Functions ---
check_xclip_installed() {
    if ! command -v xclip &> /dev/null; then
        echo "xclip could not be found."
        echo "Please install xclip to use this script."
        echo "On Ubuntu/Debian: sudo apt-get install xclip"
        echo "On Fedora: sudo dnf install xclip"
        echo "On Arch Linux: sudo pacman -S xclip"
        exit 1
    fi
}

check_required_values() {
    if [ -z "$DOMAIN" ] || [ -z "$PROXY" ]; then
        echo "Usage: $0 <domain> <proxy-backend> [output-file]"
        echo "Or set KOAD_IO_DOMAIN and KOAD_IO_BIND_IP/KOAD_IO_PORT"
        echo
        echo "Examples:"
        echo "  $0 verygood.lol http://10.241.239.7:36980"
        echo "  $0 verygood.lol http://10.241.239.7:36980 /tmp/nginx.conf"
        echo "  export KOAD_IO_DOMAIN=verygood.lol"
        echo "  export KOAD_IO_BIND_IP=10.241.239.7"
        echo "  export KOAD_IO_PORT=36980"
        echo "  $0"
        exit 1
    fi
}

# --- Args + Fallbacks ---
if [ -n "$1" ]; then
    DOMAIN="$1"
    PROXY="$2"
    OUTPUT_FILE="$3"
else
    DOMAIN="$KOAD_IO_DOMAIN"
    if [ -n "$KOAD_IO_BIND_IP" ] && [ -n "$KOAD_IO_PORT" ]; then
        PROXY="http://$KOAD_IO_BIND_IP:$KOAD_IO_PORT"
    fi
    OUTPUT_FILE="$KOAD_IO_OUTPUT_FILE"
fi

check_required_values

echo "Generating Nginx config for DOMAIN=$DOMAIN with PROXY=$PROXY"

# Paths
NGINX_TEMPLATE="$COMMAND_LOCATION/template.conf"

# Render stanza
STANZA=$(sed -e "s|<DOMAIN>|$DOMAIN|g" -e "s|<PROXY>|$PROXY|g" "$NGINX_TEMPLATE")

# Full install command block
COMMANDS=$(cat <<EOF
# Create config and enable site for $DOMAIN
sudo tee /etc/nginx/sites-available/$DOMAIN > /dev/null <<'EOF_CONF'
$STANZA
EOF_CONF

sudo ln -sf /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/$DOMAIN
sudo systemctl reload nginx
EOF
)

# Copy to clipboard or write to file
if [ -n "$OUTPUT_FILE" ]; then
    echo "$COMMANDS" > "$OUTPUT_FILE"
    echo "Config written to $OUTPUT_FILE"
else
    check_xclip_installed
    echo "$COMMANDS" | xclip -selection clipboard
    echo "Ready-to-run install commands (with stanza) copied to clipboard."
    echo "Paste them into your terminal to deploy."
fi
