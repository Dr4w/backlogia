#!/bin/sh
set -e

PUID=${PUID:-1000}
PGID=${PGID:-1000}

echo "Avvio con UID=${PUID} GID=${PGID}"

if ! getent group "$PGID" > /dev/null 2>&1; then
    groupadd -g "$PGID" appgroup
fi

if ! getent passwd "$PUID" > /dev/null 2>&1; then
    useradd -u "$PUID" -g "$PGID" -m -s /bin/sh appuser
fi

chown -R "$PUID:$PGID" /app /data /home/appuser 2>/dev/null || true

exec gosu "$PUID" "$@"