FROM ruby:2.4.4-jessie

RUN mkdir /app
COPY . /app
WORKDIR /app

# RUN apt-get update && apt-get install -y build-essential
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get install -y nodejs build-essential

RUN bundle install

WORKDIR /app/client
RUN npm install
RUN npm run build