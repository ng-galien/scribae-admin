#!/bin/bash
cp -r /app /scribae-admin && cd /scribae-admin/app \
&& bundle check || bundle install \
&& bundle exec rails db:migrate RAILS_ENV=development \
&& bundle exec rails server -p 3000 -b '0.0.0.0'