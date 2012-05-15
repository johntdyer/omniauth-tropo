# encoding: utf-8
require File.expand_path('../lib/omniauth-tropo/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth', '~> 1.0'
  gem.add_dependency 'omniauth-http-basic', '~> 1.0'

  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'multi_json'
  gem.add_development_dependency 'simplecov'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'yard'

  gem.authors = ['John Dyer']
  gem.email = ['johntdyer@gmail.com']
  gem.description = %q{Tropo strategy for OmniAuth.}
  gem.summary = gem.description
  gem.homepage = 'http://github.com/johntdyer/omniauth-tropo'

  gem.name = 'omniauth-tropo'
  gem.require_paths = ['lib']
  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = OmniAuth::Tropo::VERSION
end
