# Use the official Ruby image
FROM ruby:3.2.2

# Install dependencies
RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends nodejs sqlite3 \
    && rm -rf /var/lib/apt/lists/*  # Clean up the apt cache to reduce image size

# Set up application directory
ENV APP_PATH /myapp
RUN mkdir -p $APP_PATH
WORKDIR $APP_PATH

# Install Bundler and copy Gemfile files to install dependencies
COPY Gemfile* ./
RUN gem install bundler && bundle install

# Copy the application code
COPY . .

# Expose the Rails server port
EXPOSE 3000

# Set the default command to run the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
