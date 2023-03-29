# Use the official Jekyll Docker image as the base image
FROM ruby:3.0

# Install Jekyll and other dependencies
RUN apt-get update && \
    apt-get install -y build-essential && \
    gem install jekyll bundler

# Set the working directory to the Jekyll site directory
WORKDIR /srv/jekyll

COPY Gemfile .
COPY Gemfile.lock .
COPY jekyll-theme-chirpy.gemspec .

RUN bundle install

EXPOSE 4000

# Start Jekyll using the same command as the `docker run` command
CMD ["bundle", "exec", "jekyll", "serve", "--watch", "--force_polling", "--host", "0.0.0.0:4000"]