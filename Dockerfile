FROM ruby:2.3-alpine

WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/

RUN bundle install --jobs 4 --without development && \
    rm -rf /usr/share/ri && \
    adduser -u 9000 -D app

COPY . /usr/src/app
RUN chown -R app:app /usr/src/app

USER app

VOLUME /code
WORKDIR /code

CMD ["/usr/src/app/bin/codeclimate-haml_lint"]
