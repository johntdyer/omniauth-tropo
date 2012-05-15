# OmniAuth::Tropo

OmniAuth stratgie to get user profile from Tropo's RestAPI.

## Usage

Install manually, or just use Bundler:

    gem 'omniauth-tropo'

Add :tropo provider to omniauth builder (RAILS_ROOT/config/initializers/omniauth.rb):

    # configuration for Tropo Provisioning API
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :tropo, "http://api.tropo.com"
      # provider ...
    end

### Example:

    cd examples
    rackup config.ru
    http://localhost:9292
