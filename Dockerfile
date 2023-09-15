FROM argoproj/argocd:v2.6.12

# Switch to root for the ability to perform install
USER root

# Install tools needed for your repo-server to retrieve & decrypt secrets, render manifests 
# (e.g. curl, awscli, gpg, sops)
RUN apt-get update && \
    apt-get install -y \
        curl \
        awscli \
        gpg && \
    apt-get clean  # && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  # && \
    curl -o /usr/local/bin/sops -L https://github.com/mozilla/sops/releases/download/3.2.0/sops-3.2.0.linux && \
    chmod +x /usr/local/bin/sops
    # Install the AVP plugin (as root so we can copy to /usr/local/bin)
ENV AVP_VERSION=1.10.1
ENV BIN=argocd-vault-plugin
RUN curl -L -o ${BIN} https://github.com/argoproj-labs/argocd-vault-plugin/releases/download/v${AVP_VERSION}/argocd-vault-plugin_${AVP_VERSION}_linux_amd64
RUN chmod +x ${BIN}
RUN mv ${BIN} /usr/local/bin

# Switch back to non-root user
USER 999
