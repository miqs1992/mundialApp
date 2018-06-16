FROM phusion/passenger-ruby25:0.9.32 AS builder

# Set correct environment variables.
ENV HOME /root
ENV RAILS_ENV production

# Install dependecies
RUN apt-get update \
 && apt-get install apt-transport-https \ 
 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
 && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
 && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
 && apt-get update -qq \
 && apt-get install -y build-essential libpq-dev nodejs yarn tzdata \
 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add the Rails app and bundle
RUN mkdir /home/app/typer
WORKDIR /home/app/typer
ADD . /home/app/typer
RUN gem update --system && bundle install --deployment

#Install js libraries and precompile assets with nulldb adapter -> assets:precompile tries to reach db for some reason
RUN yarn cache clean \
 && yarn install \
 && bundle exec rake DB_ADAPTER=nulldb assets:precompile \
 && rm -rf /home/app/typer/node_modules

FROM phusion/passenger-ruby25:0.9.32
LABEL maintainer="Wojciech Mikusek" 

# Set correct environment variables.
ENV HOME /root
ENV RAILS_ENV production

# Download tzdata
RUN apt-get update -qq && apt-get install -y --no-install-recommends tzdata \
 && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Expose Nginx HTTP service
EXPOSE 80

# Start Nginx / Passenger and remove the default site
RUN rm -f /etc/service/nginx/down \
 && rm /etc/nginx/sites-enabled/default

# Add the nginx site and config
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf
ADD rails-env.conf /etc/nginx/main.d/rails-env.conf

# Add files
RUN mkdir /home/app/typer
WORKDIR /home/app/typer
COPY --from=builder /home/app/typer /home/app/typer
ENV GEM_PATH /home/app/typer/vendor/bundle/ruby/2.5.0/gems
RUN chown -R app:app /home/app/typer