FROM node:15-alpine

# Install deps
RUN apk add --update --no-cache python3 curl jq g++ make && \
    rm -rf /var/cache/apk/* && \
    python3 -m ensurepip && \
    pip3 install --upgrade pip && \
    npm install -g yo generator-hubot@next && \
    pip3 install awscli

# Install kubectl
ARG KUBECTL_VERSION=1.20.2
RUN apk add --update --no-cache curl && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    mv kubectl /usr/bin/kubectl && \
    chmod +x /usr/bin/kubectl

ENV KUBE_USER kube-gchat
ENV KUBE_GROUP kube-gchat

ENV KUBE_HOME /kube-gchat
RUN addgroup -g 501 $KUBE_GROUP && \
    adduser -D -h $KUBE_HOME -u 501 -G $KUBE_GROUP $KUBE_USER

ENV HOME $KUBE_HOME
WORKDIR $KUBE_HOME

USER kube

ENV GOOGLE_APPLICATION_CREDENTIALS /kube/hangout-hubot.json
#RUN mkdir .kube
COPY --chown=$KUBE_USER:$KUBE_GROUP package.json package-lock.json kube-gchat .kube ./
RUN npm install

COPY --chown=$KUBE_USER:$KUBE_GROUP . ./

ENTRYPOINT ["npx","kube-gchat"]
CMD ["-a","google-hangouts-chat"]
