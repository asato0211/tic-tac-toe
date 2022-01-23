FROM ruby:3.1

WORKDIR /code

COPY Gemfile ./Gemfile

RUN gem update --system \
  && gem install bundler \
  && bundle install
