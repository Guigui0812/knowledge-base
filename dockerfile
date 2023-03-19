# Use the official Jekyll Docker image as the base image
FROM ruby:3.0

RUN addgroup -S wiki_users \
 && adduser -S wiki_user -G wiki_users
 
USER wiki_user

# Install Jekyll and other dependencies
RUN apt-get update && \
    apt-get install -y build-essential && \
    gem install jekyll bundler

# Set the working directory to the Jekyll site directory
WORKDIR /srv/jekyll

# Copy the Jekyll site files into the Docker image
COPY . /srv/jekyll

# Mount a volume for the generated site files
VOLUME /srv/jekyll/_posts

# Expose port 4000
EXPOSE 4000

# Build the Jekyll site inside the Docker image
RUN bundle

# Start Jekyll using the same command as the `docker run` command
CMD ["jekyll", "serve", "--watch", "--force_polling", "--host", "0.0.0.0"]


