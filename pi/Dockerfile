FROM node:24-alpine

USER root

# -------------------------
# Base development tools
# -------------------------
RUN apk add --no-cache \
        bash \
        git \
        curl \
        wget \
        unzip \
        zip \
        jq \
        ripgrep \
        fd \
        build-base \
        ca-certificates \
        icu-libs \
        krb5-libs \
        libgcc \
        libssl3 \
        libstdc++ \
        tzdata \
        zlib \
        neovim

# -------------------------
# Pi Coding Agent
# -------------------------
RUN npm install -g --ignore-scripts \
        @earendil-works/pi-coding-agent

# -------------------------
# .NET SDKs
# -------------------------
ENV DOTNET_ROOT=/usr/share/dotnet
ENV PATH="/root/.dotnet/tools:${PATH}"
ENV DOTNET_CLI_TELEMETRY_OPTOUT=1
ENV DOTNET_NOLOGO=1

RUN curl -fsSL https://dot.net/v1/dotnet-install.sh \
        -o /tmp/dotnet-install.sh \
    && chmod +x /tmp/dotnet-install.sh \
    \
    && /tmp/dotnet-install.sh \
        --channel 8.0 \
        --install-dir /usr/share/dotnet \
    \
    && /tmp/dotnet-install.sh \
        --channel 9.0 \
        --install-dir /usr/share/dotnet \
    \
    && /tmp/dotnet-install.sh \
        --channel 10.0 \
        --install-dir /usr/share/dotnet \
    \
    && ln -s /usr/share/dotnet/dotnet /usr/local/bin/dotnet \
    && rm /tmp/dotnet-install.sh

# -------------------------
# .NET Global Tools
# -------------------------
RUN dotnet tool install --global dotnet-ef

# -------------------------
# Go
# -------------------------
ARG TARGETARCH

RUN case "$TARGETARCH" in \
        amd64) GOARCH=amd64 ;; \
        arm64) GOARCH=arm64 ;; \
        *) echo "Unsupported architecture: $TARGETARCH" && exit 1 ;; \
    esac \
    && GO_VERSION=1.25.0 \
    && curl -fsSL \
        "https://go.dev/dl/go${GO_VERSION}.linux-${GOARCH}.tar.gz" \
        -o /tmp/go.tar.gz \
    && tar -C /usr/local -xzf /tmp/go.tar.gz \
    && rm /tmp/go.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

# -------------------------
# Pi directories
# -------------------------
RUN mkdir -p \
    /root/.pi/agent \
    /root/.pi/agent/sessions \
    /root/.pi/agent/extensions \
    /root/.pi/agent/skills \
    /root/.pi/agent/prompts \
    /root/.pi/agent/themes \
    /root/.local/share/nvim/spell \
    /workspace

# Global Pi configuration. The launcher mounts /root/.pi/agent as a volume,
# so retain a seed outside that mount and restore it at container startup.
COPY pi/config/settings.json /usr/local/share/pi/settings.json
# Image-managed extensions are copied into the persistent Pi volume at startup.
COPY pi/extensions/ /usr/local/share/pi/extensions/
COPY pi/docker-entrypoint.sh /usr/local/bin/pi-entrypoint
RUN chmod 755 /usr/local/bin/pi-entrypoint

# Optional global AGENTS.md
# COPY configs/AGENTS.md /root/.pi/agent/AGENTS.md

# Optional extensions / skills
# COPY extensions/ /root/.pi/agent/extensions/
# COPY skills/ /root/.pi/agent/skills/
# COPY prompts/ /root/.pi/agent/prompts/
# COPY themes/ /root/.pi/agent/themes/

# Neovim config
COPY nvim/ /root/.config/nvim/

ENV EDITOR=nvim

WORKDIR /workspace

ENTRYPOINT ["/usr/local/bin/pi-entrypoint"]
