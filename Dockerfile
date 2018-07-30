# Scribae Docker image
FROM ruby:2.5.1

# Set the locale
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8 

# Install Ruby packages 
RUN apt-get update -qq && apt-get install -y build-essential ruby ruby-all-dev libpq-dev sqlite3 libsqlite3-dev nodejs

# Install bundler
RUN gem install bundler
# Important, allow multiple bundler install https://github.com/bundler/bundler/issues/6154
ENV BUNDLE_GEMFILE='./Gemfile'

# Create app dir
RUN mkdir /app
COPY . /app
WORKDIR /app
RUN mkdir /scribae-admin

VOLUME ["/scribae-admin"]

COPY Gemfile /app/Gemfile
RUN touch /app/Gemfile.lock

# Install rails and jekyll with Bundler 
RUN bundle install --system --jobs=4
COPY . /app
RUN cd /app/prototypes/default && bundle install --system --jobs=4
# Entry point script
COPY ./entry-point.sh /
RUN ["chmod", "+x", "./entry-point.sh"]

ENTRYPOINT [ "./entry-point.sh" ]

EXPOSE 3000