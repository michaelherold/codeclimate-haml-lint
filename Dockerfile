FROM ruby:2.5.1-alpine

LABEL maintainer "Michael J. Herold <opensource@michaeljherold.com>"

WORKDIR /usr/src/app
COPY Gemfile* ./

RUN apk add --update build-base && \
    bundle install --jobs 4 --without development ci && \
    rm -rf /usr/share/ri && \
    adduser -u 9000 -D app && \
    apk del build-base

COPY engine.json /
COPY . ./
RUN chown -R app:app ./

USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/bin/codeclimate-haml-lint"]
