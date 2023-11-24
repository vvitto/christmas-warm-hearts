FROM ruby:3.1.3-alpine3.17 as base

WORKDIR /usr/src/app

COPY Gemfile* ./

RUN apk add --no-cache gcompat tzdata postgresql-libs && \
    apk add --update-cache --no-cache --virtual .build-deps g++ make linux-headers postgresql-dev \
    && bundle install --jobs $(nproc) --retry 3 \
    && rm -rf /usr/local/bundle/cache/*.gem \
    && find /usr/local/bundle/gems/ -name "*.c" -delete \
    && find /usr/local/bundle/gems/ -name "*.o" -delete \
    && apk --purge del .build-deps

COPY . .

CMD ["bin/bundle", "exec", "puma", "--log-requests"]

FROM base as production

RUN RAILS_ENV=production bundle exec rake assets:precompile