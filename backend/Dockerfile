FROM ruby:2.6.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /umbrellio
WORKDIR /umbrellio
COPY Gemfile /umbrellio/Gemfile
COPY Gemfile.lock /umbrellio/Gemfile.lock
COPY . /umbrellio
RUN gem install bundler
RUN gem install foreman
RUN bundle install
RUN bundle update

# Start the main process.
#CMD ["foreman", "start"]
