# Two Questions

* ...
```
# Create DB and run migrations
rails db:migrate:reset

# Install gems
bundle install

# Start Redis
brew services start redis

# Start Memcache
brew install memcached
brew services start memcached

# Turn on caching
rails dev:cache

# Start server
rails s
```