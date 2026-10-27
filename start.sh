#!/bin/sh

# Render автоматически задает переменную PORT
ACTUAL_PORT=${PORT:-10000}

# Создаем конфиг Xray
cat <<EOF > /etc/xray.json
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": ${ACTUAL_PORT},
      "listen": "0.0.0.0",
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "86ab7dca-7664-4382-bce2-d3d31b4afcef"
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "/vless"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom"
    }
  ]
}
EOF

# Запускаем Xray
echo "Starting Xray on port ${ACTUAL_PORT}..."
xray -c /etc/xray.json
