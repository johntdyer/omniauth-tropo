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

If you want to pull roles from the ProvisioningAPI ( Premise only ) you can do so by adding :role_options hash in the builder:

    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :tropo, "http://yourserver.com:8080/rest", :role_options=>{:admin_username=>'admin',:admin_password=>'admin'}
    end

### Example:

    cd examples
    rackup config.ru
    http://localhost:9292
