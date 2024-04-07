FROM ruby:3.2.3

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -qq && apt-get install -y nodejs default-mysql-client

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
