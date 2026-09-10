function pi() {
  docker run --rm -it \
    --cap-drop=ALL \
    --security-opt=no-new-privileges \
    --add-host=host.docker.internal:host-gateway \
    --pids-limit=512 \
    --memory=8g \
    --cpus=4 \
    -v "$PWD:/workspace" \
    -v pi-agent-data:/root/.pi/agent \
    -w /workspace \
    agents/pi:latest "$@"
}
