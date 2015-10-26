require 'sinatra/base'
require "redis"

# beginning of kitchen sink tester in ruby
# goal - test while being as obvious as possible whats wrong - which means as little magic as possible.
host = ENV["REDIS_MASTER_SERVICE_HOST"] ||= "localhost"
port = ENV["REDIS_MASTER_SERVICE_PORT"] ||=  "6379"

$redis = Redis.new(host: host, port: port)

class TinyApp < Sinatra::Base
  get "/" do
    "OK!!"
  end

  post "/redis" do
    if params[:key] and not params[:key].empty?
      key = params[:key]
      $redis.set("key", key)
    end

    "Redis key set to #{key}"
  end

  get "/redis" do
    key = $redis.get("key")

    "Redis key is #{key}"
  end
end
