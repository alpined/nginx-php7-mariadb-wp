
apk add --no-cache curl bash wget ca-certificates
    
S6_OVERLAY_VERSION=v3.2.1.0
curl -sSL https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz | tar xfz - -C /
