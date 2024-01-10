# Use an official Ruby runtime on Alpine as a parent image
FROM ruby:2.7-alpine

# Install build dependencies for native gems and then clean up
RUN apk add --no-cache --update build-base \
    linux-headers \
    git \
    postgresql-dev \
    tzdata \
    && rm -rf /var/cache/apk/*

# Set the working directory in the Docker container
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile* ./

# Install any needed gems specified in Gemfile
RUN bundle config set without 'development test' && bundle install --jobs 4

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Define the script to run when starting your container
CMD ["rails", "server", "-b", "0.0.0.0"]