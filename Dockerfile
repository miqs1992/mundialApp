FROM phusion/passenger-ruby25:0.9.32
LABEL maintainer="Wojciech Mikusek" 

# Set correct environment variables.
ENV HOME /root
ENV RAILS_ENV production

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Expose Nginx HTTP service
EXPOSE 80

# Start Nginx / Passenger
RUN rm -f /etc/service/nginx/down

# Remove the default site
RUN rm /etc/nginx/sites-enabled/default

# Add the nginx site and config
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

# Install dependecies
RUN apt-get update && apt-get install apt-transport-https
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs yarn tzdata

# Install bundle of gems
WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN gem update --system && bundle install

# Add the Rails app
RUN mkdir /home/app/typer
WORKDIR /home/app/typer
ADD . /home/app/typer
RUN chown -R app:app /home/app/typer

#Install js libraries and precompile assets with nulldb adapter -> assets:precompile tries to reach db for some reason
RUN yarn cache clean
RUN yarn install
RUN bundle exec rake DB_ADAPTER=nulldb assets:precompile

# Clean up APT and bundler when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Bootsnap needs it after compilation
RUN chown -R app:app /home/app/typer
