
apk add --no-cache curl ca-certificates
    
S6_OVERLAY_VERSION=v2.0.0.1
curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xfz - -C /
