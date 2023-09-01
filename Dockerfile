FROM fluentd:v1.16.0-1.0
LABEL maintainer="zhangzhongqiqi@126.com"

USER root

RUN apk add --no-cache --update --virtual .build-deps sudo build-base ruby-dev \
        && sudo gem install elasticsearch -v 7.8.1 \
        && sudo gem install fluent-plugin-elasticsearch -v 4.1.1 \
        && sudo gem sources --clear-all && apk del .build-deps \
        && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

RUN mkdir -p /etc/td-agent/config.d/ && chown -R fluent:fluent /etc/td-agent/ && chmod -R 775 /etc/td-agent/

USER fluent