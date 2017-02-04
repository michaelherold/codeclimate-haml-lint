FROM ruby:2.4-alpine

WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN bundle install -j 4 && \
    rm -rf /usr/share/ri && \
    adduser -u 9000 -D app

COPY . /usr/src/app
RUN chown -R app:app /usr/src/app

USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/bin/codeclimate-haml_lint"]
