require 'bundler/setup'
require 'sinatra/base'
require 'omniauth-tropo'

class App < Sinatra::Base
  get '/' do
    redirect '/auth/tropo'
  end

  post '/auth/:provider/callback' do
    content_type 'application/json'
    MultiJson.encode(request.env)
  end

  get '/auth/failure' do
    content_type 'application/json'
    MultiJson.encode(request.env)
  end
end

use Rack::Session::Cookie

use OmniAuth::Builder do
  provider :tropo, "http://api.tropo.com"
end

run App.new
