function oc() {
  docker run --rm -it \
    --cap-drop=ALL \
    --security-opt=no-new-privileges \
    --pids-limit=512 \
    --memory=8g \
    --cpus=4 \
    -v "$PWD:/workspace" \
    -v opencode-data:/root/.local/share/opencode \
    -v opencode-nvim-data:/root/.local/share/nvim \
    -v opencode-state:/root/.local/state/opencode \
    -w /workspace \
    test/opencode:v1 "$@"
    #ghcr.io/anomalyco/opencode "$@"
}
