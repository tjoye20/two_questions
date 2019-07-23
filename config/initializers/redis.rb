if ENV["RAILS_ENV"] == 'production'
    uri = URI.parse(ENV["REDIS_PROVIDER"])
    $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
else
  $redis = Redis.new
end
