FROM ruby:2.3-alpine

LABEL maintainer "Michael J. Herold <michael@michaeljherold.com>"

WORKDIR /usr/src/app
COPY Gemfile* ./

RUN bundle install --jobs 4 --without development ci && \
    rm -rf /usr/share/ri && \
    adduser -u 9000 -D app

COPY engine.json /
COPY . ./
RUN chown -R app:app ./

USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/bin/codeclimate-haml-lint"]
