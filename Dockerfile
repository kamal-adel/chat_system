# Use the official Ruby image from the Docker Hub
FROM ruby:3.2.2

# Set environment variables
ENV RAILS_ENV=development
ENV RAILS_ROOT /app

# Set working directory
WORKDIR $RAILS_ROOT

# Install dependencies
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.2.32
RUN bundle install

# Copy application code
COPY . .

# Expose port 3000
EXPOSE 3000

# Start Rails server
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
