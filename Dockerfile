FROM ruby:2.4.1-jessie

RUN mkdir /app
COPY . /app
WORKDIR /app

# RUN apt-get update && apt-get install -y build-essential
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get install -y nodejs build-essential

RUN bundle install
RUN npm install