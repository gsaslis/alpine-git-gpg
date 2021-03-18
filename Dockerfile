FROM alpine/git:latest

LABEL Description="This is a container image with git and gpg to allow you to sign commits with GPG and push them to some other repo."

RUN apk update && apk add --no-cache gnupg

# Add user name to /etc/passwd at runtime, with an arbitrary uid. Needed for openshift deployments with non-root users.
COPY bin/fixUser.sh /usr/bin/fixUser.sh
RUN chmod +x /usr/bin/fixUser.sh

ENV HOME=/home/git \
    USER=10001 \
    GITHUB_CLI_VERSION=1.7.0\
    GNUPGHOME=/tmp/.gnupg

RUN mkdir -p ${HOME} && \
    chown -R ${USER}:0 ${HOME} && \
    chmod -R g=u ${HOME} /etc/passwd

ADD https://github.com/cli/cli/releases/download/v${GITHUB_CLI_VERSION}/gh_${GITHUB_CLI_VERSION}_linux_386.tar.gz /tmp/gh_${GITHUB_CLI_VERSION}_linux_386.tar.gz

RUN tar \
    --strip-components=2 \
    --extract \
    --file /tmp/gh_${GITHUB_CLI_VERSION}_linux_386.tar.gz \
    gh_${GITHUB_CLI_VERSION}_linux_386/bin/gh \
  && mv gh /usr/bin/

### Containers should NOT run as root as a good practice
USER ${USER}
WORKDIR ${HOME}