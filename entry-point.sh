#!/bin/bash
rsync -av /tmp/scribae-admin/db/ /scribae-admin/db/ \
&& mkdir -p /scribae-admin/public/upload/images \
&& cd /scribae-admin \
&& bundle check || bundle install \
&& rake db:exists && rake db:migrate || rake db:setup \
&& bundle exec rails server -p 3000 -b '0.0.0.0'