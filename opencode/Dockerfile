FROM ghcr.io/anomalyco/opencode:latest

USER root

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

COPY configs/opencode.jsonc /root/.config/opencode/opencode.jsonc
COPY agents/ /root/.config/opencode/agents/
COPY configs/nvim/ /root/.config/nvim/

RUN mkdir -p /root/.local/share/nvim/spell

ENV EDITOR=nvim
