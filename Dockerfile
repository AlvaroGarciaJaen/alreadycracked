FROM ruby:2.6.5
RUN mkdir -p /app
WORKDIR /app
COPY . /app/
RUN gem install bundler
RUN bundle install
EXPOSE 80/tcp
CMD ["rackup", "config.ru", "--host", "0.0.0.0", "-p", "80"]
