FROM ruby:2.5.1
MAINTAINER Ramon Tayag <ramon.tayag@gmail.com>

RUN apt-get update -qq && \
  apt-get upgrade -y && \
  apt-get install -y build-essential libpq-dev nodejs postgresql-client && \
  rm -rf /var/lib/apt/lists/*

ENV APP=/app
ENV PATH=$APP/bin:$PATH

RUN mkdir $APP

WORKDIR $APP

ENV BUNDLE_GEMFILE=$APP/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/bundle \
  PATH=./bin:$PATH \
  RAILS_PORT=3000 \
  RAILS_BINDING=0.0.0.0 \
  RAILS_ENV=development

ADD . $APP

CMD ["bundle", "exec", "rails", "s", "-p", $RAILS_PORT, "-b", $RAILS_BINDING]
