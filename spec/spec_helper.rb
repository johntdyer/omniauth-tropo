$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start
require 'rspec'
require 'faraday'
require 'rack/test'
require 'webmock/rspec'
require 'omniauth'
require 'fakeweb'
require 'omniauth-tropo'

FakeWeb.allow_net_connect = false

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.extend  OmniAuth::Test::StrategyMacros, :type => :strategy
end
