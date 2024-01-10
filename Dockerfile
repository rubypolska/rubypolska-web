# Use an official Ruby runtime as a parent image
FROM ruby:2.7

# Install Node.js and build dependencies for native gems
RUN apt-get update -qq && apt-get install -y build-essential libxml2-dev libxslt1-dev \
    postgresql-client libpq-dev git tzdata nodejs npm graphviz

# Set the working directory in the Docker container
WORKDIR /usr/src/app

# Copy the Gemfile and Gemfile.lock into the container
COPY Gemfile* ./

# Install any needed gems specified in Gemfile
RUN bundle install --jobs 4

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Define the script to run when starting your container
CMD ["rails", "server", "-b", "0.0.0.0"]