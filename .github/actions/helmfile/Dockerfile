FROM quay.io/roboll/helmfile:v0.143.1 as builder

FROM craftech/ci-tools:kube-tools-latest

RUN apk update \
    && apk add bash

ARG SOPS_VERSION=3.7.2
ADD https://github.com/mozilla/sops/releases/download/v${SOPS_VERSION}/sops-v${SOPS_VERSION}.linux /usr/local/bin/sops
RUN chmod 755 /usr/local/bin/sops && \
    apk update && \
    apk add --no-cache jq && \
    rm -rf /var/cache/apk/*

# Copying helmfile binary and deploy.sh file
COPY --from=builder /usr/local/bin/helmfile /usr/local/bin/helmfile
COPY entrypoint.sh /usr/local/bin/entrypoint

RUN chmod +x /usr/local/bin/entrypoint

ENTRYPOINT [ "/usr/local/bin/entrypoint" ]
