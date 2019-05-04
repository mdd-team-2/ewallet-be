FROM ruby:2.5-alpine

RUN apk add --no-cache \
    build-base \
    tzdata \
    git \
    postgresql-dev \
    nodejs \
    imagemagick
    
RUN mkdir /ewallet

WORKDIR /ewallet

ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true
ENV WEB_CONCURRENCY 2
ENV MIN_THREADS 5
ENV MAX_THREADS 20
ENV PORT=80

ADD Gemfile /ewallet/Gemfile
ADD Gemfile.lock /ewallet/Gemfile.lock

COPY . .

RUN bundle install



LABEL maintainer="CAMILO DAJER <cadajerp@unal.edu.co>"

EXPOSE 80

CMD puma -C config/puma.rb  

