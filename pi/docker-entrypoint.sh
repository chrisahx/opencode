#!/bin/sh
set -eu

# The launcher mounts /root/.pi/agent as a named volume.  That mount hides
# files baked into the image, so seed the repository-managed settings after
# the volume has been mounted.
install -D -m 600 /usr/local/share/pi/settings.json /root/.pi/agent/settings.json

exec pi "$@"
