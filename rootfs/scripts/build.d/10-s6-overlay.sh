apk add --no-cache curl bash wget ca-certificates

S6_OVERLAY_VERSION=3.2.1.0
curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz | tar -C / -Jxpf -
curl -sSL https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-i686.tar.xz | tar -C / -Jxpf -
