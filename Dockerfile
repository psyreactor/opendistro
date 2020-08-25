FROM ruby:2.7

WORKDIR /app

COPY . ./
RUN bundle install
RUN gem build opendistro.gemspec
RUN gem install $(ls . | grep opendistro-*.gem)

CMD ["irb"]