#!/bin/sh
set -eu

# The launcher mounts /root/.pi/agent as a named volume.  That mount hides
# files baked into the image, so seed the repository-managed settings after
# the volume has been mounted.
install -D -m 600 /usr/local/share/pi/settings.json /root/.pi/agent/settings.json

# Keep image-managed extensions reproducible even though the Pi directory is a
# named volume. Runtime-installed extensions in other paths remain untouched.
mkdir -p /root/.pi/agent/extensions
for extension in /usr/local/share/pi/extensions/*.ts; do
  [ -e "$extension" ] || continue
  install -m 644 "$extension" "/root/.pi/agent/extensions/$(basename "$extension")"
done

exec pi "$@"
