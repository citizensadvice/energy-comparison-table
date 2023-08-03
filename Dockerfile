FROM ruby:3.2.2-alpine3.18

RUN apk update && apk add --no-cache build-base yarn libxml2 libxslt gcompat git

RUN gem install bundler -v '~>2.3'

WORKDIR /app

COPY Gemfile Gemfile.lock /app/

RUN bundle config set --local deployment 'true' && \  
    bundle install

COPY package.json yarn.lock /app/
RUN yarn install --frozen-lockfile

RUN mkdir /.cache
RUN mkdir /.cache/yarn
RUN chmod 777 -R /.cache/yarn

COPY ./ /app

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
