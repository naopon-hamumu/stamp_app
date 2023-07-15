FROM ruby:3.1.4
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /stamp_app
WORKDIR /stamp_app
ADD Gemfile /stamp_app/Gemfile
ADD Gemfile.lock /stamp_app/Gemfile.lock
RUN bundle install
ADD . /myapp