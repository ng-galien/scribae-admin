# Scribae Docker image
FROM ruby:2.5.1

# Set the locale
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8 

# Install Ruby packages 
RUN apt-get update -qq && apt-get install -y build-essential ruby ruby-all-dev libpq-dev sqlite3 libsqlite3-dev nodejs rsync

# Install bundler
RUN gem install bundler
# Important, allow multiple bundler install https://github.com/bundler/bundler/issues/6154
ENV BUNDLE_GEMFILE='./Gemfile'

# Default argument when not provided in the --build-arg
ARG LOCALBUILD=false
COPY . /tmp/scribae-admin
#RUN ls -l /tmp
RUN if [ "$LOCALBUILD" = "true" ] ; then mkdir /scribae-admin &&  rsync -a /tmp/scribae-admin/ /scribae-admin/ ; else git clone . --recurse-submodules https://github.com/ng-galien/scribae-admin.git; fi
# Create app dir
#RUN ls -l /scribae-admin

# Install rails and jekyll with Bundler 
RUN cd /scribae-admin && touch Gemfile.lock && bundle install --system --jobs=4
RUN cd /scribae-admin/prototypes/default && touch Gemfile.lock && bundle install --system --jobs=4
# Entry point script
COPY ./entry-point.sh /
RUN ["chmod", "+x", "./entry-point.sh"]
#
ENTRYPOINT [ "./entry-point.sh" ]
#
VOLUME ["/scribae-admin/db"]
VOLUME ["/scribae-admin/public/upload/images"]

EXPOSE 3000