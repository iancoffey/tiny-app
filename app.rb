require 'sinatra/base'

class TinyApp < Sinatra::Base
  get '/' do
    "OK!"
  end
end
