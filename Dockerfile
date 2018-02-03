FROM alpine:3.6

MAINTAINER Zack Shahan <z.shahan@gmail.com>

ENV KUBERNETES_VERSION v1.8.6
ENV HELM_VERSION v2.7.2
ENV HELM_FILENAME helm-${HELM_VERSION}-linux-amd64.tar.gz

WORKDIR /

RUN apk add --update --no-cache curl git ca-certificates bash ruby\
  && apk add --update -t deps gettext tar gzip \
  && curl -L https://storage.googleapis.com/kubernetes-release/release/${KUBERNETES_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
  && curl -L https://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} | tar xz \ 
  && mv linux-amd64/helm /usr/local/bin/helm \ 
  && rm -rf linux-amd64 \
  && chmod +x /usr/local/bin/kubectl /usr/local/bin/helm \
  && apk del --purge deps \
  && rm /var/cache/apk/*

CMD ["helm","help"]
