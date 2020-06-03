# Docker Image to improve the deploy Rails with Dokku and Oracle Instant Client

This Docker Image should help you to deploy your Ruby on Rails application with Dokku and Oracle Instant Client dependencies if you are using [ruby-oci8](https://rubygems.org/gems/ruby-oci8/versions/2.2.2) gem.

## Setting up Ruby on Rails

This image just setup the Ruby enviroment. To setup Rails enviroment, put following.

For Dokku, put the following:

```Dockerfile
FROM alutsu/ruby-oracle-node-yarn

# Install Ruby Gems and node modules
COPY Gemfile* /tmp/
COPY package.json /tmp/
COPY yarn.lock /tmp/
WORKDIR /tmp
RUN gem install bundler
RUN bundle install --jobs 5 --retry 5 --without development test
RUN yarn install
RUN mkdir /app
WORKDIR /app
COPY . /app
ENV RAILS_ENV production

# Execute the Procfile
CMD ["bin/run-dev.sh"]
```

Feel free to contribute, just open a Pull Request.