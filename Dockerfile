FROM ruby:2.7.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /app
WORKDIR /app
EXPOSE 3000
COPY Gemfile .
COPY Gemfile.lock .
RUN gem install bundler
RUN bundle install 
COPY . /app