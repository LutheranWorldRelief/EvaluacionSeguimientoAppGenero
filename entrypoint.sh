#!/bin/bash
set -e

export RAILS_ENV=production
gem install unicorn -v 5.1.0
# Remove a potentially pre-existing unicorn.pid for unicorn.
rm -f /app/pids/unicorn.pid
rm -f /app/tmp/server.pid

rm -rf tmp
ln -s /tmp/rails-app tmp

# bundle exec rake app:update:bin
# bundle exec rails g simple_form:install
# bundle exec rake assets:precompile --trace

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"

