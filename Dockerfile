FROM alpine:3.16.3

LABEL maintainer="jakobjs" \
      version="0.0.1"

ARG SERVICE_USER
ARG SERVICE_HOME

ENV SERVICE_USER ${SERVICE_USER:-alpine}
ENV SERVICE_HOME ${SERVICE_HOME:-/home/${SERVICE_USER}}

RUN apk add --no-cache \
        bash \
        dumb-init \
        openssh

RUN adduser -h ${SERVICE_HOME} -s /sbin/nologin -u 1000 -D ${SERVICE_USER} && \
    sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

USER    ${SERVICE_USER}
WORKDIR ${SERVICE_HOME}
VOLUME  ${SERVICE_HOME}

ENTRYPOINT [ "/usr/bin/dumb-init", "--" ]
CMD [ "bash" ]
